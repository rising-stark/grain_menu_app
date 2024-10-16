module Types
  class ItemModifierGroupType < BaseObject
    field :item_identifier, String, null: false
    field :modifier_group_identifier, String, null: false
    field :display_order, Integer, null: true
    field :default_quantity, Integer, null: true
    field :price_override, Float, null: true

    def modifier_group_identifier
      object.modifier_group.identifier
    end

    def item_identifier
      object.item.identifier
    end
  end
end
