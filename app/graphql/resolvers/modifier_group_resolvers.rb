module Resolvers
  class ModifierGroupResolvers < BaseResolver
    type [Types::ModifierGroupType], null: false

    def resolve
      ModifierGroup.all
    end

    class Show < BaseResolver
      argument :identifier, String, required: true
      type Types::ModifierGroupType, null: false

      def resolve(identifier:)
        ModifierGroup.find_by!(identifier: identifier)
      end
    end
  end
end
