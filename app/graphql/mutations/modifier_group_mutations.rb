module Mutations
  class ModifierGroupMutations < BaseMutation
    class CreateModifierGroup < BaseMutation
      argument :modifier_group, Types::ModifierGroupInputType, required: true
      argument :item_identifier, String, required: false

      field :modifier_group, Types::ModifierGroupType, null: false

      def resolve(modifier_group:, item_identifier: nil)
        new_modifier_group = ModifierGroup.new(
          identifier: modifier_group[:identifier],
          label: modifier_group[:label],
          selection_required_min: modifier_group[:selection_required_min],
          selection_required_max: modifier_group[:selection_required_max]
        )

        ActiveRecord::Base.transaction do
          new_modifier_group.save!

          create_modifiers(new_modifier_group, modifier_group[:modifiers], item_identifier) if modifier_group[:modifiers].present?

          create_item_modifier_group(item_identifier, modifier_group[:identifier]) if item_identifier.present?
        end

        { modifier_group: new_modifier_group }
      end

      private

      def create_modifiers(modifier_group, modifiers, item_identifier)
        modifiers.each_with_index do |modifier_params, i|
          modifier_mutation = Mutations::ModifierMutations::CreateModifier.new(object: nil, field: nil, context: context)
          modifier_response = modifier_mutation.resolve(
            modifier: modifier_params, item_identifier: item_identifier, modifier_group_identifier: modifier_group[:identifier]
          )
        end
      end

      def create_item_modifier_group(item_identifier, modifier_group_identifier)
        item_modifier_group_mutation = Mutations::ItemModifierGroupMutations::CreateItemModifierGroup.new(object: nil, field: nil, context: context)
        item_modifier_group_mutation.resolve(item_identifier: item_identifier, modifier_group_identifier: modifier_group_identifier)
      end
    end

    class UpdateModifierGroup < BaseMutation
      argument :modifier_group, Types::ModifierGroupInputType, required: true
      argument :item_identifier, String, required: false

      field :modifier_group, Types::ModifierGroupType, null: false

      def resolve(modifier_group:, item_identifier: nil)
        existing_modifier_group = ModifierGroup.find_by!(identifier: modifier_group[:identifier])

        attributes = {}
        attributes[:label] = modifier_group[:label] if modifier_group[:label].present?
        attributes[:selection_required_min] = modifier_group[:selection_required_min] if modifier_group[:selection_required_min].present?
        attributes[:selection_required_max] = modifier_group[:selection_required_max] if modifier_group[:selection_required_max].present?

        existing_modifier_group.assign_attributes(attributes)

        ActiveRecord::Base.transaction do
          existing_modifier_group.save!
          update_modifiers(existing_modifier_group, modifier_group[:modifiers], item_identifier) if modifier_group[:modifiers].present?

          update_item_modifier_group(item_identifier, modifier_group[:identifier]) if item_identifier.present?
        end

        { modifier_group: existing_modifier_group }
      end

      private

      def update_modifiers(modifier_group, modifiers, item_identifier)
        modifiers.each_with_index do |modifier_params, i|
          modifier = Modifier.find_by(modifier_group: modifier_group)

          if modifier.present?
            modifier_mutation = Mutations::ModifierMutations::UpdateModifier.new(object: nil, field: nil, context: context)
          else
            modifier_mutation = Mutations::ModifierMutations::CreateModifier.new(object: nil, field: nil, context: context)
          end

          modifier_response = modifier_mutation.resolve(
            modifier: modifier_params, item_identifier: item_identifier, modifier_group_identifier: modifier_group[:identifier]
          )
        end
      end

      def update_item_modifier_group(item_identifier, modifier_group_identifier)
        item_modifier_group_mutation = Mutations::ItemModifierGroupMutations::UpdateItemModifierGroup.new(object: nil, field: nil, context: context)
        item_modifier_group_mutation.resolve(item_identifier: item_identifier, modifier_group_identifier: modifier_group_identifier)
      end
    end

    class DestroyModifierGroup < BaseMutation
      argument :identifier, String, required: true

      field :success, Boolean, null: false

      def resolve(identifier:)
        modifier_group = ModifierGroup.find_by!(identifier: identifier)

        modifier_group.destroy!
        { success: true }
      end
    end
  end
end
