module Types
  class ItemType < BaseObject
    field :identifier, String, null: false
    field :label, String, null: false
    field :price, Float, null: false
    field :type, String, null: false
    field :description, String, null: true
    field :created_at, GraphQL::Types::ISO8601Date, null: false
    field :updated_at, GraphQL::Types::ISO8601Date, null: false
    # field :modifier_groups, [Types::ModifierGroupType], null: true
    # field :modifiers, [Types::ModifierType], null: true
  end
end
