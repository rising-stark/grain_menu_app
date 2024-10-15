module Resolvers
  class SectionResolvers < BaseResolver
    type [Types::SectionType], null: false

    def resolve
      Section.all
    end

    class Show < BaseResolver
      argument :identifier, String, required: true
      type Types::SectionType, null: false

      def resolve(identifier:)
        Section.find_by!(identifier: identifier)
      end
    end
  end
end
