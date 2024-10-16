class Section < ApplicationRecord
  has_one :menu_section, dependent: :destroy
  has_one :menu, through: :menu_section
  has_many :section_items, dependent: :destroy
  has_many :items, through: :section_items

  validates :identifier, presence: true, uniqueness: true
  validates :label, presence: true

  def ordered_items
    items.joins(:section_item).order('section_items.display_order ASC')
  end
end
