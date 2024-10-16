module Types
  class ModifierGroupInputType < BaseInputObject
    argument :identifier, String, required: true
    argument :label, String, required: true
    argument :selection_required_min, Integer, required: false
    argument :selection_required_max, Integer, required: false
    argument :modifiers, [Types::ModifierInputType], required: false
  end
end
