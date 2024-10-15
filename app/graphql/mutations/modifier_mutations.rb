module Mutations
  class ModifierMutations < BaseMutation
    field :modifier, Types::ModifierType, null: false

    class Create < BaseMutation
      argument :item_id, ID, required: true
      argument :modifier_group_id, ID, required: true
      argument :display_order, Integer, required: false
      argument :price, Float, required: false

      def resolve(item_id:, modifier_group_id:, display_order: nil, price: nil)
        modifier = Modifier.new(item_id: item_id, modifier_group_id: modifier_group_id, display_order: display_order, price: price)

        if modifier.save
          { modifier: modifier }
        else
          raise GraphQL::ExecutionError.new(modifier.errors.full_messages.join(", "))
        end
      end
    end

    class Update < BaseMutation
      argument :id, ID, required: true
      argument :item_id, ID, required: false
      argument :modifier_group_id, ID, required: false
      argument :display_order, Integer, required: false
      argument :price, Float, required: false

      def resolve(id:, item_id: nil, modifier_group_id: nil, display_order: nil, price: nil)
        modifier = Modifier.find(id)
        modifier.assign_attributes(item_id: item_id, modifier_group_id: modifier_group_id, display_order: display_order, price: price)

        if modifier.save
          { modifier: modifier }
        else
          raise GraphQL::ExecutionError.new(modifier.errors.full_messages.join(", "))
        end
      end
    end

    class Destroy < BaseMutation
      argument :id, ID, required: true
      field :success, Boolean, null: false

      def resolve(id:)
        modifier = Modifier.find(id)
        if modifier.destroy
          { success: true }
        else
          raise GraphQL::ExecutionError.new("Failed to delete Modifier")
        end
      end
    end
  end
end
