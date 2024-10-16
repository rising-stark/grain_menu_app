module Types
  class MenuSectionType < BaseObject
    field :menu_identifier, String, null: false
    field :section_identifier, String, null: false
    field :display_order, Integer, null: true

    def menu_identifier
      object.menu.identifier
    end

    def section_identifier
      object.section.identifier
    end
  end
end
