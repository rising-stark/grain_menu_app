module Mutations
  class MenuSectionMutations < BaseMutation
    class CreateMenuSection < BaseMutation
      argument :menu_identifier, String, required: true
      argument :section_identifier, String, required: true
      # TODO: Allow inserting a menu section in between previous sections.

      field :menu_section, Types::MenuSectionType, null: false

      def resolve(menu_identifier:, section_identifier:)
        menu = Menu.find_by!(identifier: menu_identifier)
        section = Section.find_by!(identifier: section_identifier)

        last_display_order = MenuSection.where(menu: menu).maximum(:display_order) || 0
        menu_section = MenuSection.new(menu: menu, section: section, display_order: last_display_order + 1)
        menu_section.save!

        { menu_section: menu_section }
      end
    end

    class UpdateMenuSection < BaseMutation
      argument :menu_identifier, String, required: true
      argument :section_identifier, String, required: true
      # TODO: Allow moving a menu section from display_order a to b.

      field :menu_section, Types::MenuSectionType, null: false

      def resolve(menu_identifier:, section_identifier:)
        menu = Menu.find_by!(identifier: menu_identifier)
        section = Section.find_by!(identifier: section_identifier)

        existing_menu_section = MenuSection.find_by(section: section)
        menu_section = nil

        ActiveRecord::Base.transaction do
          existing_menu_section.destroy! if existing_menu_section && existing_menu_section.menu != menu
          return if existing_menu_section && existing_menu_section.menu == menu

          last_display_order = MenuSection.where(menu: menu).maximum(:display_order) || 0
          menu_section = MenuSection.new(menu: menu, section: section, display_order: last_display_order + 1)
          menu_section.save!
        end

        { menu_section: menu_section }
      end
    end

    class DestroyMenuSection < BaseMutation
      argument :menu_identifier, String, required: true
      argument :section_identifier, String, required: true

      field :success, Boolean, null: false

      def resolve(menu_identifier:, section_identifier:)
        menu = Menu.find_by!(identifier: menu_identifier)
        section = Section.find_by!(identifier: section_identifier)
        menu_section = MenuSection.find_by!(menu: menu, section: section)

        menu_section.destroy!

        { success: true }
      end
    end
  end
end
