module Mutations
  class SectionMutations < BaseMutation
    class CreateSection < BaseMutation
      argument :identifier, String, required: true
      argument :label, String, required: true
      argument :description, String, required: false

      field :section, Types::SectionType, null: false

      def resolve(identifier:, label:, description: nil)
        section = Section.new(identifier: identifier, label: label, description: description)
        section.save!
        { section: section }
      end
    end

    class UpdateSection < BaseMutation
      argument :identifier, String, required: true
      argument :label, String, required: false
      argument :description, String, required: false

      field :section, Types::SectionType, null: false

      def resolve(identifier:, label: nil, description: nil)
        section = Section.find_by!(identifier: identifier)

        attributes = {}
        attributes[:label] = label if label.present?
        attributes[:description] = description if description.present?

        section.assign_attributes(attributes)
        section.save!
        { section: section }
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
