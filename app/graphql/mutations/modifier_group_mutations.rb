module Mutations
  class ModifierGroupMutations < BaseMutation
    class CreateModifierGroup < BaseMutation
      argument :identifier, String, required: true
      argument :label, String, required: true
      argument :selection_required_min, Integer, required: false
      argument :selection_required_max, Integer, required: false

      field :modifier_group, Types::ModifierGroupType, null: false

      def resolve(identifier:, label:, selection_required_min: nil, selection_required_max: nil)
        modifier_group = ModifierGroup.new(
          identifier: identifier,
          label: label,
          selection_required_min: selection_required_min,
          selection_required_max: selection_required_max
        )
        modifier_group.save!
        { modifier_group: modifier_group }
      end
    end

    class UpdateModifierGroup < BaseMutation
      argument :identifier, String, required: true
      argument :label, String, required: false
      argument :selection_required_min, Integer, required: false
      argument :selection_required_max, Integer, required: false

      field :modifier_group, Types::ModifierGroupType, null: false

      def resolve(identifier:, label: nil, selection_required_min: nil, selection_required_max: nil)
        modifier_group = ModifierGroup.find_by!(identifier: identifier)

        attributes = {}
        attributes[:label] = label if label.present?
        attributes[:selection_required_min] = selection_required_min if selection_required_min.present?
        attributes[:selection_required_max] = selection_required_max if selection_required_max.present?

        modifier_group.assign_attributes(attributes)
        modifier_group.save!
        { modifier_group: modifier_group }
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
