module Types
  class MutationType < GraphQL::Schema::Object
    field :create_menu, mutation: Mutations::MenuMutations::CreateMenu
    field :update_menu, mutation: Mutations::MenuMutations::UpdateMenu
    field :delete_menu, mutation: Mutations::MenuMutations::DestroyMenu

    field :create_section, mutation: Mutations::SectionMutations::CreateSection
    field :update_section, mutation: Mutations::SectionMutations::UpdateSection
    field :delete_section, mutation: Mutations::SectionMutations::DestroySection

    field :create_item, mutation: Mutations::ItemMutations::CreateItem
    field :update_item, mutation: Mutations::ItemMutations::UpdateItem
    field :delete_item, mutation: Mutations::ItemMutations::DestroyItem

    field :create_modifier_group, mutation: Mutations::ModifierGroupMutations::CreateModifierGroup
    field :update_modifier_group, mutation: Mutations::ModifierGroupMutations::UpdateModifierGroup
    field :delete_modifier_group, mutation: Mutations::ModifierGroupMutations::DestroyModifierGroup

    field :create_modifier, mutation: Mutations::ModifierMutations::CreateModifier
    field :update_modifier, mutation: Mutations::ModifierMutations::UpdateModifier
    field :delete_modifier, mutation: Mutations::ModifierMutations::DestroyModifier
  end
end
