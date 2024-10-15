module Types
  class MenuType < BaseObject
    field :identifier, String, null: false
    field :label, String, null: false
    field :state, String, null: false
    field :start_date, GraphQL::Types::ISO8601Date, null: true
    field :end_date, GraphQL::Types::ISO8601Date, null: true
    field :created_at, GraphQL::Types::ISO8601Date, null: false
    field :updated_at, GraphQL::Types::ISO8601Date, null: false
    field :sections, [Types::SectionType], null: true

    def sections
      object.ordered_sections
    end
  end
end
