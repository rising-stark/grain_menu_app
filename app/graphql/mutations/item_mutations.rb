module Mutations
  class ItemMutations < BaseMutation
    class CreateItem < BaseMutation
      argument :identifier, String, required: true
      argument :label, String, required: true
      argument :price, Float, required: true
      argument :type, String, required: true
      argument :description, String, required: false

      field :item, Types::ItemType, null: false

      def resolve(identifier:, type:, label:, price:, description: nil)
        item = Item.new(identifier: identifier, label: label, description: description, type: type, price: price)
        item.save!
        { item: item }
      end
    end

    class UpdateItem < BaseMutation
      argument :identifier, String, required: true
      argument :label, String, required: false
      argument :price, Float, required: false
      argument :type, String, required: false
      argument :description, String, required: false

      field :item, Types::ItemType, null: false

      def resolve(identifier:, label: nil, price: nil, type: nil, description: nil)
        item = Item.find_by!(identifier: identifier)

        attributes = {}
        attributes[:label] = label if label.present?
        attributes[:price] = price if price.present?
        attributes[:type] = type if type.present?
        attributes[:description] = description if description.present?

        item.assign_attributes(attributes)
        item.save!
        { item: item }
      end
    end

    class DestroyItem < BaseMutation
      argument :identifier, String, required: true

      field :success, Boolean, null: false

      def resolve(identifier:)
        item = Item.find_by!(identifier: identifier)

        item.destroy!
        { success: true }
      end
    end
  end
end
