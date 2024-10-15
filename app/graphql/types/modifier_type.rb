module Types
  class ModifierType < BaseObject
    field :default_quantity, Integer, null: false
    field :price_override, Float, null: true
    field :created_at, GraphQL::Types::ISO8601Date, null: false
    field :updated_at, GraphQL::Types::ISO8601Date, null: false
    # field :item, Types::ItemType, null: false
    # field :modifier_group, Types::ModifierGroupType, null: false
  end
end
