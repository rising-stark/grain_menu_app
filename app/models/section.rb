class Section < ApplicationRecord
  has_many :menu_sections
  has_many :menus, through: :menu_sections
  has_many :section_items
  has_many :items, through: :section_items

  validates :identifier, presence: true, uniqueness: true
  validates :label, presence: true

  def ordered_items
    Item
      .joins(:section_items)
      .where(section_items: { section_id: id })
      .select('items.*, section_items.display_order')
      .order('section_items.display_order, items.id')
      .distinct
  end
end
