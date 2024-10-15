class Item < ApplicationRecord
  self.inheritance_column = :_type_disabled
  enum type: { Product: 'Product', Component: 'Component' }

  has_many :section_items
  has_many :sections, through: :section_items
  has_many :item_modifier_groups
  has_many :modifiers
  has_many :modifier_groups, through: :item_modifier_groups

  validates :identifier, presence: true, uniqueness: true
  validates :label, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :type, inclusion: { in: types.keys }
end
