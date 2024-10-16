module Types
  class ModifierInputType < BaseInputObject
    argument :display_order, Integer, required: false
    argument :default_quantity, Integer, required: false
    argument :price_override, Float, required: false
  end
end
