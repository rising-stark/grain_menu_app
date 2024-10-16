class Modifier < ApplicationRecord
  belongs_to :item
  belongs_to :modifier_group

  validates :modifier_group_id, presence: true
  validates :item_id, presence: true, uniqueness: true

  validates :default_quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :display_order, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :price_override, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  default_scope { order(:display_order) }
end
