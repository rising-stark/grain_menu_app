module Mutations
  class ItemMutations < BaseMutation
    class CreateItem < BaseMutation
      argument :item, Types::ItemInputType, required: true
      argument :section_identifier, String, required: false
      # TODO: Allow passing a display_order attribute as well.

      field :item, Types::ItemType, null: false

      def resolve(item:, section_identifier: nil)
        new_item = Item.new(
          identifier: item[:identifier],
          label: item[:label],
          price: item[:price],
          type: item[:type],
          description: item[:description]
        )

        ActiveRecord::Base.transaction do
          new_item.save!

          create_modifier_groups(new_item, item[:modifier_groups]) if item[:modifier_groups].present?

          create_section_item(section_identifier, item[:identifier]) if section_identifier.present?
        end

        { item: new_item }
      end

      private

      def create_modifier_groups(item, modifier_groups)
        modifier_groups.each do |modifier_group_params|
          modifier_group_mutation = Mutations::ModifierGroupMutations::CreateModifierGroup.new(object: nil, field: nil, context: context)
          modifier_group_response = modifier_group_mutation.resolve(modifier_group: modifier_group_params, item_identifier: item[:identifier])

          # if modifier_group_response[:modifier_group]
          #   ItemModifierGroup.create!(item: item, modifier_group: modifier_group_response[:modifier_group])
          # end
        end
      end

      def create_section_item(section_identifier, item_identifier)
        section_item_mutation = Mutations::SectionItemMutations::CreateSectionItem.new(object: nil, field: nil, context: context)
        section_item_mutation.resolve(section_identifier: section_identifier, item_identifier: item_identifier)
      end
    end

    class UpdateItem < BaseMutation
      argument :item, Types::ItemInputType, required: true
      argument :section_identifier, String, required: false

      field :item, Types::ItemType, null: false

      def resolve(item:, section_identifier: nil)
        existing_item = Item.find_by!(identifier: item[:identifier])

        attributes = {}
        attributes[:label] = item[:label] if item[:label].present?
        attributes[:price] = item[:price] if item[:price].present?
        attributes[:type] = item[:type] if item[:type].present?
        attributes[:description] = item[:description] if item[:description].present?

        existing_item.assign_attributes(attributes)

        ActiveRecord::Base.transaction do
          existing_item.save!

          update_modifier_groups(existing_item, item[:modifier_groups]) if item[:modifier_groups].present?

          update_section_item(section_identifier, existing_item) if section_identifier.present?
        end

        { item: existing_item }
      end

      private

      def update_modifier_groups(item, modifier_groups)
        modifier_groups.each_with_index do |modifier_group_params, i|
          modifier_group = ModifierGroup.find_by(identifier: modifier_group_params[:identifier])

          if modifier_group.present?
            modifier_group_mutation = Mutations::ModifierGroupMutations::UpdateModifierGroup.new(object: nil, field: nil, context: context)
          else
            modifier_group_mutation = Mutations::ModifierGroupMutations::CreateModifierGroup.new(object: nil, field: nil, context: context)
          end

          modifier_group_response = modifier_group_mutation.resolve(
            modifier_group: modifier_group_params, item_identifier: item[:identifier]
          )
          # modifier_group = modifier_group_response[:modifier_group]

          # item_modifier_group = ItemModifierGroup.find_or_initialize_by(item: item, modifier_group: modifier_group)
          # last_display_order = item.item_modifier_groups.maximum(:display_order) || 0
          # item_modifier_group.update!(display_order: last_display_order + i + 1)
        end
      end

      def update_section_item(section_identifier, item)
        section_item_mutation = Mutations::SectionItemMutations::UpdateSectionItem.new(object: nil, field: nil, context: context)
        section_item_mutation.resolve(section_identifier: section_identifier, item_identifier: item[:identifier])
      end
    end

    class DestroyItem < BaseMutation
      argument :identifier, String, required: true

      field :success, Boolean, null: false

      def resolve(identifier:)
        item = Item.find_by!(identifier: identifier)

        item.destroy!
        { success: true }
      end
    end
  end
end
