module Types
  class SectionInputType < BaseInputObject
    argument :identifier, String, required: true
    argument :label, String, required: true
    argument :description, String, required: false
    argument :created_at, GraphQL::Types::ISO8601Date, required: false
    argument :updated_at, GraphQL::Types::ISO8601Date, required: false
    # argument :items, [Types::ItemType], required: false
  end
end
