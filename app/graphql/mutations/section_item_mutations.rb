module Mutations
  class SectionItemMutations < BaseMutation
    class CreateSectionItem < BaseMutation
      argument :section_identifier, String, required: true
      argument :item_identifier, String, required: true
      # TODO: Allow inserting a section item in between previous items.

      field :section_item, Types::SectionItemType, null: false

      def resolve(section_identifier:, item_identifier:)
        section = Section.find_by!(identifier: section_identifier)
        item = Item.find_by!(identifier: item_identifier)

        last_display_order = SectionItem.where(section: section).maximum(:display_order) || 0
        section_item = SectionItem.new(section: section, item: item, display_order: last_display_order + 1)
        section_item.save!

        { section_item: section_item }
      end
    end

    class UpdateSectionItem < BaseMutation
      argument :section_identifier, String, required: true
      argument :item_identifier, String, required: true
      # TODO: Allow moving a section item from display_order a to b.

      field :section_item, Types::SectionItemType, null: false

      def resolve(section_identifier:, item_identifier:)
        section = Section.find_by!(identifier: section_identifier)
        item = Item.find_by!(identifier: item_identifier)
        section_item = nil

        existing_section_item = SectionItem.find_by(item: item)

        ActiveRecord::Base.transaction do
          existing_section_item.destroy! if existing_section_item && existing_section_item.section != section
          return if existing_section_item && existing_section_item.section == section

          last_display_order = SectionItem.where(section: section).maximum(:display_order) || 0
          section_item = SectionItem.new(section: section, item: item, display_order: last_display_order + 1)
          section_item.save!
        end

        { section_item: section_item }
      end
    end

    class DestroySectionItem < BaseMutation
      argument :section_identifier, String, required: true
      argument :item_identifier, String, required: true

      field :success, Boolean, null: false

      def resolve(section_identifier:, item_identifier:)
        section = Section.find_by!(identifier: section_identifier)
        item = Item.find_by!(identifier: item_identifier)
        section_item = SectionItem.find_by!(section: section, item: item)

        section_item.destroy!

        { success: true }
      end
    end
  end
end
