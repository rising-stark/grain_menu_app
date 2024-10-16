class ModifierGroup < ApplicationRecord
  has_many :modifiers, dependent: :destroy
  has_one :item_modifier_group, dependent: :destroy
  has_one :item, through: :item_modifier_group

  validates :identifier, presence: true, uniqueness: true
  validates :label, presence: true
  validates :selection_required_min, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validates :selection_required_max, numericality: { only_integer: true, greater_than_or_equal_to: :selection_required_min }, allow_nil: true
end
