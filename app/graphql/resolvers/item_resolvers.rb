module Resolvers
  class ItemResolvers < BaseResolver
    type [Types::ItemType], null: false

    def resolve
      Item.all
    end

    class Show < BaseResolver
      argument :identifier, String, required: true
      type Types::ItemType, null: false

      def resolve(identifier:)
        Item.find_by!(identifier: identifier)
      rescue ActiveRecord::RecordNotFound => e
        handle_error(e)
      end
    end
  end
end
