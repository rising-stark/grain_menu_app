class ItemModifierGroup < ApplicationRecord
  belongs_to :item
  belongs_to :modifier_group

  validates :item_id, presence: true
  validates :modifier_group_id, presence: true, uniqueness: true
end
