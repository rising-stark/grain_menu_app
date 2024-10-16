module Mutations
  class ModifierMutations < BaseMutation
    class CreateModifier < BaseMutation
      argument :modifier, Types::ModifierInputType, required: true
      argument :item_identifier, String, required: true
      argument :modifier_group_identifier, String, required: true

      field :modifier, Types::ModifierType, null: false

      def resolve(modifier:, item_identifier:, modifier_group_identifier:)
        item = Item.find_by!(identifier: item_identifier)
        modifier_group = ModifierGroup.find_by!(identifier: modifier_group_identifier)

        last_display_order = Modifier.where(item: item).maximum(:display_order) || 0
        modifier = Modifier.new(
          item: item,
          modifier_group: modifier_group,
          display_order: modifier[:display_order] || last_display_order + 1,
          default_quantity: modifier[:default_quantity],
          price_override: modifier[:price_override]
        )
        modifier.save!

        { modifier: modifier }
      end
    end

    class UpdateModifier < BaseMutation
      argument :modifier, Types::ModifierInputType, required: true
      argument :item_identifier, String, required: true
      argument :modifier_group_identifier, String, required: true

      field :modifier, Types::ModifierType, null: false

      def resolve(modifier:, item_identifier:, modifier_group_identifier:)
        item = Item.find_by!(identifier: item_identifier)
        modifier_group = ModifierGroup.find_by!(identifier: modifier_group_identifier)
        new_modifier = nil
        existing_modifier = Modifier.find_by(item: item)

        ActiveRecord::Base.transaction do
          existing_modifier.destroy! if existing_modifier && existing_modifier.modifier_group != modifier_group
          if existing_modifier && existing_modifier.modifier_group == modifier_group
            attributes = {}
            attributes[:display_order] = modifier[:display_order] if modifier[:display_order].present?
            attributes[:price_override] = modifier[:price_override] if modifier[:price_override].present?
            attributes[:default_quantity] = modifier[:default_quantity] if modifier[:default_quantity].present?

            existing_modifier.assign_attributes(attributes)

            existing_modifier.save!
            new_modifier = existing_modifier
          else
            last_display_order = Modifier.where(item: item).maximum(:display_order) || 0
            new_modifier = Modifier.new(
              item: item,
              modifier_group: modifier_group,
              price_override: modifier[:price_override],
              default_quantity: modifier[:default_quantity],
              display_order: modifier[:display_order].prescence || last_display_order + 1
            )
            new_modifier.save!
          end

        end

        { modifier: new_modifier }
      end
    end

    class DestroyModifier < BaseMutation
      argument :item_identifier, String, required: true
      argument :modifier_group_identifier, String, required: true

      field :success, Boolean, null: false

      def resolve(item_identifier:, modifier_group_identifier:)
        item = Item.find_by!(identifier: item_identifier)
        modifier_group = ModifierGroup.find_by!(identifier: modifier_group_identifier)
        modifier = Modifier.find_by!(item: item, modifier_group: modifier_group)

        modifier.destroy!

        { success: true }
      end
    end
  end
end
