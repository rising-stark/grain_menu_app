class MenuSection < ApplicationRecord
  belongs_to :menu
  belongs_to :section

  validates :menu_id, presence: true
  validates :section_id, presence: true, uniqueness: true

  validates :display_order, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
