module Types
  class ItemInputType < BaseInputObject
    argument :identifier, String, required: true
    argument :label, String, required: true
    argument :price, Float, required: true
    argument :type, String, required: true
    argument :description, String, required: false
    argument :modifier_groups, [Types::ModifierGroupInputType], required: false
    argument :modifier, Types::ModifierInputType, required: false
  end
end
