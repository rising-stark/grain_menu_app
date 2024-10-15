module Types
  class ModifierGroupType < BaseObject
    field :identifier, String, null: false
    field :label, String, null: false
    field :selection_required_min, Integer, null: false
    field :selection_required_max, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601Date, null: false
    field :updated_at, GraphQL::Types::ISO8601Date, null: false
    field :modifiers, [Types::ModifierType], null: true
  end
end
