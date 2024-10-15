class Menu < ApplicationRecord
  has_many :menu_sections
  has_many :sections, through: :menu_sections

  enum state: { menu_active: 'active', menu_inactive: 'inactive', menu_archived: 'archived', menu_pending: 'pending' }

  validates :identifier, presence: true, uniqueness: true
  validates :label, presence: true
  validates :end_date, comparison: { greater_than: :start_date }, if: -> { end_date.present? && start_date.present? }

  def ordered_sections
    Section
      .joins(:menu_sections)
      .where(menu_sections: { menu_id: id })
      .select('sections.*, menu_sections.display_order')
      .order('menu_sections.display_order, sections.id')
      .distinct
  end
end
