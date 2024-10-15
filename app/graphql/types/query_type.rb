module Types
  class QueryType < Types::BaseObject
    field :menus, resolver: Resolvers::MenuResolvers
    field :menu, resolver: Resolvers::MenuResolvers::Show

    field :sections, resolver: Resolvers::SectionResolvers
    field :section, resolver: Resolvers::SectionResolvers::Show

    field :items, resolver: Resolvers::ItemResolvers
    field :item, resolver: Resolvers::ItemResolvers::Show

    field :modifier_groups, resolver: Resolvers::ModifierGroupResolvers
    field :modifier_group, resolver: Resolvers::ModifierGroupResolvers::Show

    field :modifiers, resolver: Resolvers::ModifierResolvers
    field :modifier, resolver: Resolvers::ModifierResolvers::Show
  end
end
