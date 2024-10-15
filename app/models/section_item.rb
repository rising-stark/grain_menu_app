class SectionItem < ApplicationRecord
  belongs_to :section
  belongs_to :item

  validates :section, presence: true
  validates :item, presence: true
  validates :display_order, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
