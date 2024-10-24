module Resolvers
  class MenuResolvers < BaseResolver
    type [Types::MenuType], null: false

    def resolve
      Menu.all
    end

    class Show < BaseResolver
      argument :identifier, String, required: true
      type Types::MenuType, null: false

      def resolve(identifier:)
        Menu.find_by!(identifier: identifier)
      end
    end
  end
end
