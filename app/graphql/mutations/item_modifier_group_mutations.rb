module Mutations
  class ItemModifierGroupMutations < BaseMutation
    class CreateItemModifierGroup < BaseMutation
      argument :item_identifier, String, required: true
      argument :modifier_group_identifier, String, required: true

      field :item_modifier_group, Types::ItemModifierGroupType, null: false

      def resolve(item_identifier:, modifier_group_identifier:)
        item = Item.find_by!(identifier: item_identifier)
        modifier_group = ModifierGroup.find_by!(identifier: modifier_group_identifier)

        item_modifier_group = ItemModifierGroup.new(item: item, modifier_group: modifier_group)
        item_modifier_group.save!

        { item_modifier_group: item_modifier_group }
      end
    end

    class UpdateItemModifierGroup < BaseMutation
      argument :item_identifier, String, required: true
      argument :modifier_group_identifier, String, required: true

      field :item_modifier_group, Types::ItemModifierGroupType, null: false

      def resolve(item_identifier:, modifier_group_identifier:)
        item = Item.find_by!(identifier: item_identifier)
        modifier_group = ModifierGroup.find_by!(identifier: modifier_group_identifier)
        item_modifier_group = ItemModifierGroup.find_by!(item: item, modifier_group: modifier_group)

        item_modifier_group.update!(item: item, modifier_group: modifier_group)

        { item_modifier_group: item_modifier_group }
      end
    end

    class DestroyItemModifierGroup < BaseMutation
      argument :item_identifier, String, required: true
      argument :modifier_group_identifier, String, required: true

      field :success, Boolean, null: false

      def resolve(item_identifier:, modifier_group_identifier:)
        item = Item.find_by!(identifier: item_identifier)
        modifier_group = ModifierGroup.find_by!(identifier: modifier_group_identifier)
        item_modifier_group = ItemModifierGroup.find_by!(item: item, modifier_group: modifier_group)

        item_modifier_group.destroy!

        { success: true }
      end
    end
  end
end
