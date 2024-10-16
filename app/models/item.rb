class Item < ApplicationRecord
  self.inheritance_column = :_type_disabled
  enum type: { Product: 'Product', Component: 'Component' }

  has_one :section_item, dependent: :destroy
  has_one :modifier, dependent: :destroy
  has_one :section, through: :section_item
  has_many :item_modifier_groups, dependent: :destroy
  has_many :modifier_groups, through: :item_modifier_groups

  validates :identifier, presence: true, uniqueness: true
  validates :label, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :type, inclusion: { in: types.keys }
end
