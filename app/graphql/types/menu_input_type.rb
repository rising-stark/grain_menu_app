module Types
  class MenuInputType < BaseInputObject
    argument :identifier, String, required: true
    argument :label, String, required: true
    argument :state, String, required: true
    argument :start_date, GraphQL::Types::ISO8601Date, required: false
    argument :end_date, GraphQL::Types::ISO8601Date, required: false
    argument :sections, [Types::SectionInputType], required: false
  end
end
