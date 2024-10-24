module Resolvers
  class ModifierResolvers < BaseResolver
    type [Types::ModifierType], null: false

    def resolve
      Modifier.all
    end

    class Show < BaseResolver
      argument :identifier, String, required: true
      type Types::ModifierType, null: false

      def resolve(identifier:)
        Modifier.find_by!(identifier: identifier)
      end
    end
  end
end
