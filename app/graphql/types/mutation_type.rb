module Types
  class MutationType < GraphQL::Schema::Object
    field :create_menu, mutation: Mutations::MenuMutations
    field :update_menu, mutation: Mutations::MenuMutations
    field :delete_menu, mutation: Mutations::MenuMutations

    field :create_section, mutation: Mutations::SectionMutations
    field :update_section, mutation: Mutations::SectionMutations
    field :delete_section, mutation: Mutations::SectionMutations

    field :create_item, mutation: Mutations::ItemMutations
    field :update_item, mutation: Mutations::ItemMutations
    field :delete_item, mutation: Mutations::ItemMutations

    field :create_modifier_group, mutation: Mutations::ModifierGroupMutations
    field :update_modifier_group, mutation: Mutations::ModifierGroupMutations
    field :delete_modifier_group, mutation: Mutations::ModifierGroupMutations

    field :create_modifier, mutation: Mutations::ModifierMutations
    field :update_modifier, mutation: Mutations::ModifierMutations
    field :delete_modifier, mutation: Mutations::ModifierMutations
  end
end
