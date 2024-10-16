module Types
  class SectionType < BaseObject
    field :identifier, String, null: false
    field :label, String, null: false
    field :description, String, null: true
    field :created_at, GraphQL::Types::ISO8601Date, null: false
    field :updated_at, GraphQL::Types::ISO8601Date, null: false
    field :items, [Types::ItemType], null: true
    field :menu, Types::MenuType, null: true

    def items
      object.ordered_items
    end
  end
end
