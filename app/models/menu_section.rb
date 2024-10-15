class MenuSection < ApplicationRecord
  belongs_to :menu
  belongs_to :section

  validates :menu, :section, presence: true
  validates_uniqueness_of :section_id, scope: :menu_id

  validates :display_order, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
