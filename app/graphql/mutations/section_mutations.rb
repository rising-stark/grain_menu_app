module Mutations
  class SectionMutations < BaseMutation
    class CreateSection < BaseMutation
      argument :section, Types::SectionInputType, required: true
      argument :menu_identifier, String, required: false
      # TODO: Allow passing a display_order attribute as well.

      field :section, Types::SectionType, null: false

      def resolve(section:, menu_identifier: nil)
        #TODO: Add DynamicBuilderPattern
        new_section = Section.new(
          identifier: section[:identifier],
          label: section[:label],
          description: section[:description]
        )

        ActiveRecord::Base.transaction do
          new_section.save!

          create_items(new_section, section[:items]) if section[:items].present?
          create_menu_section(menu_identifier, section[:identifier]) if menu_identifier.present?
        end

        { section: new_section }
      end

      private

      def create_items(section, items)
        items.each_with_index do |item_params, i|
          item_mutation = Mutations::ItemMutations::CreateItem.new(object: nil, field: nil, context: context)
          item_response = item_mutation.resolve(item: item_params)

          if item_response[:item].present?
            SectionItem.create!(section: section, item: item_response[:item], display_order: i)
          end
        end
      end

      def create_menu_section(menu_identifier, section_identifier)
        menu_section_mutation = Mutations::MenuSectionMutations::CreateMenuSection.new(object: nil, field: nil, context: context)
        menu_section_mutation.resolve(menu_identifier: menu_identifier, section_identifier: section_identifier)
      end
    end

    class UpdateSection < BaseMutation
      argument :section, Types::SectionInputType, required: true
      argument :menu_identifier, String, required: false
      # TODO: Allow passing a display_order attribute as well.

      field :section, Types::SectionType, null: false

      def resolve(section:, menu_identifier: nil)
        existing_section = Section.find_by!(identifier: section[:identifier])

        attributes = {}
        attributes[:label] = section[:label] if section[:label].present?
        attributes[:description] = section[:description] if section[:description].present?
        existing_section.assign_attributes(attributes)

        ActiveRecord::Base.transaction do
          existing_section.save!
          update_items(existing_section, section[:items]) if section[:items].present?

          update_menu_section(menu_identifier, section[:identifier]) if menu_identifier.present?
        end

        { section: existing_section }
      end

      private

      def update_items(section, items)
        items.each_with_index do |item_params, i|
          item = Item.find_by(identifier: item_params[:identifier])

          #TODO: Refactor and turn into separate function and name strategy pattern
          if item.present?
            item_mutation = Mutations::ItemMutations::UpdateItem.new(object: nil, field: nil, context: context)
          else
            item_mutation = Mutations::ItemMutations::CreateItem.new(object: nil, field: nil, context: context)
          end

          item_response = item_mutation.resolve(item: item_params, section_identifier: section[:identifier])
          # item = item_response[:item]

          # section_item = SectionItem.find_or_initialize_by(section: section, item: item)
          # last_display_order = section.section_items.maximum(:display_order) || 0
          # section_item.update!(display_order: last_display_order + i + 1)
        end
      end

      def update_menu_section(menu_identifier, section_identifier)
        menu_section_mutation = Mutations::MenuSectionMutations::UpdateMenuSection.new(object: nil, field: nil, context: context)
        menu_section_mutation.resolve(menu_identifier: menu_identifier, section_identifier: section_identifier)
      end
    end

    class DestroySection < BaseMutation
      argument :identifier, String, required: true

      field :success, Boolean, null: false

      def resolve(identifier:)
        section = Section.find_by!(identifier: identifier)

        section.destroy!
        { success: true }
      end
    end
  end
end
