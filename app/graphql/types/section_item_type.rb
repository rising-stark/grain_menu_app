module Types
  class SectionItemType < BaseObject
    field :section_identifier, String, null: false
    field :item_identifier, String, null: false
    field :display_order, Integer, null: true

    def section_identifier
      object.section.identifier
    end

    def item_identifier
      object.item.identifier
    end
  end
end
