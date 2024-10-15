module Mutations
  class MenuMutations < BaseMutation
    class CreateMenu < BaseMutation
      argument :identifier, String, required: true
      argument :label, String, required: true
      argument :state, String, required: true
      argument :start_date, GraphQL::Types::ISO8601Date, required: false
      argument :end_date, GraphQL::Types::ISO8601Date, required: false
      argument :sections, [Types::SectionInputType], required: false

      field :menu, Types::MenuType, null: false

      def resolve(identifier:, label:, state:, start_date: nil, end_date: nil, sections: [])
        menu = Menu.new(identifier: identifier, label: label, state: state, start_date: start_date, end_date: end_date)
        menu.save!
        # create_menu_sections(menu, sections) if sections
        { menu: menu }
      end

      private

      def create_menu_sections(menu, sections)
        sections.each_with_index do |section_params, i|
          section_mutation = Mutations::SectionMutations::CreateSection.new
          section_response = section_mutation.resolve(
            identifier: section_params.identifier,
            label: section_params.label,
            description: section_params.description,
            context: {}
          )

          if section_response[:section]
            MenuSection.create!(menu: menu, section: section_response[:section], display_order: i)
          end
        end
      end
    end

    class UpdateMenu < BaseMutation
      argument :identifier, String, required: true
      argument :label, String, required: false
      argument :state, String, required: false
      argument :start_date, GraphQL::Types::ISO8601Date, required: false
      argument :end_date, GraphQL::Types::ISO8601Date, required: false

      field :menu, Types::MenuType, null: false

      def resolve(identifier:, label: nil, state: nil, start_date: nil, end_date: nil)
        menu = Menu.find_by!(identifier: identifier)

        attributes = {}
        attributes[:label] = label if label.present?
        attributes[:state] = state if state.present?
        attributes[:start_date] = start_date if start_date.present?
        attributes[:end_date] = end_date if end_date.present?

        menu.assign_attributes(attributes)
        menu.save!
        { menu: menu }
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
