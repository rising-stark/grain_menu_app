module Mutations
  class MenuMutations < BaseMutation
    class CreateMenu < BaseMutation
      argument :menu, Types::MenuInputType, required: true

      field :menu, Types::MenuType, null: false

      def resolve(menu:)
        #TODO: Add DynamicBuilderPattern
        new_menu = Menu.new(
          identifier: menu[:identifier],
          label: menu[:label],
          state: menu[:state],
          start_date: menu[:start_date],
          end_date: menu[:end_date]
        )

        ActiveRecord::Base.transaction do
          new_menu.save!
          create_menu_sections(new_menu, menu[:sections]) if menu[:sections].present?
        end

        { menu: new_menu }
      end

      private

      def create_menu_sections(menu, sections)
        sections.each_with_index do |section_params, i|
          section_mutation = Mutations::SectionMutations::CreateSection.new(object: nil, field: nil, context: context)
          section_response = section_mutation.resolve(section: section_params, menu_identifier: menu[:identifier])
        end
      end
    end

    class UpdateMenu < BaseMutation
      argument :menu, Types::MenuInputType, required: true

      field :menu, Types::MenuType, null: false

      def resolve(menu:)
        existing_menu = Menu.find_by!(identifier: menu[:identifier])

        attributes = {}
        attributes[:label] = menu[:label] if menu[:label].present?
        attributes[:state] = menu[:state] if menu[:state].present?
        attributes[:start_date] = menu[:start_date] if menu[:start_date].present?
        attributes[:end_date] = menu[:end_date] if menu[:end_date].present?

        existing_menu.assign_attributes(attributes)

        ActiveRecord::Base.transaction do
          existing_menu.save!
          update_menu_sections(existing_menu, menu[:sections]) if menu[:sections].present?
        end

        { menu: existing_menu }
      end

      private

      def update_menu_sections(menu, sections)
        sections.each_with_index do |section_params, i|
          section = Section.find_by(identifier: section_params[:identifier])

          #TODO: Refactor and turn into separate function and name strategy pattern
          if section.present?
            section_mutation = Mutations::SectionMutations::UpdateSection.new(object: nil, field: nil, context: context)
          else
            section_mutation = Mutations::SectionMutations::CreateSection.new(object: nil, field: nil, context: context)
          end

          section_response = section_mutation.resolve(section: section_params, menu_identifier: menu[:identifier])
          # section = section_response[:section]

          # menu_section = MenuSection.find_or_initialize_by(menu: menu, section: section)
          # last_display_order = menu.menu_sections.maximum(:display_order) || 0
          # menu_section.update!(display_order: last_display_order + i + 1)
        end
      end
    end

    class DestroyMenu < BaseMutation
      argument :identifier, String, required: true

      field :success, Boolean, null: false

      def resolve(identifier:)
        menu = Menu.find_by!(identifier: identifier)

        menu.destroy!
        { success: true }
      end
    end
  end
end
