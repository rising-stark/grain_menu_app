class SectionItem < ApplicationRecord
  belongs_to :section
  belongs_to :item

  validates :section_id, presence: true
  validates :item_id, presence: true, uniqueness: true

  validates :display_order, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
