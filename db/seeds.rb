# Clear existing data
MenuSection.destroy_all
SectionItem.destroy_all
ItemModifierGroup.destroy_all
Menu.destroy_all
Section.destroy_all
Item.destroy_all
Modifier.destroy_all
ModifierGroup.destroy_all

# Create a new menu
menu = Menu.create!(
  identifier: "menu_1",
  label: "Test Menu",
  state: "active",
  start_date: Time.current
)

section1 = Section.create!(
  identifier: "section_1",
  label: "Section 1",
  description: "Non-Configurable",
  locked: true,
  menu: menu
)

section2 = Section.create!(
  identifier: "section_2",
  label: "Section 2",
  description: "Configurable",
  menu: menu
)

ncf_items = []
cf_items = []
3.times do |i|
  # Non-configurable items in Section 1
  item = Item.create!(
    identifier: "s1_item_#{i + 1}",
    label: "s1_Item #{i + 1}",
    description: "s1_Non-Configurable Item #{i + 1}",
    price: (5 + i) * 100,
    type: "Product",
    section: section1
  )
  ncf_items.push(item)

  item = Item.create!(
    identifier: "s2_item_#{i + 1}",
    label: "s2_Item #{i + 1}",
    description: "s2_Non-Configurable Item #{i + 1}",
    price: (i+1),
    type: "Product",
    section: section2
  )
  cf_items.push(item)
end

# Create modifier groups for the configurable item
modifier_group1 = ModifierGroup.create!(
  identifier: "size_group",
  label: "Size",
  selection_required_min: 1,
  selection_required_max: 1,
  item: cf_items[0]
)

# Modifiers for the size group
3.times do |i|
  Modifier.create!(
    modifier_group: modifier_group1,
    item: cf_items[i],
    price_override: (i+1)*2,
    default_quantity: 1,
    display_order: i
  )
end

puts "Seeding completed successfully!"
