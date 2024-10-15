class Modifier < ApplicationRecord
  belongs_to :item
  belongs_to :modifier_group

  validates :item, presence: true
  validates :modifier_group, presence: true
  validates :default_quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :display_order, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :price_override, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end
