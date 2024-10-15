# db/seeds.rb

# Clear existing data
MenuSection.destroy_all
SectionItem.destroy_all
ItemModifierGroup.destroy_all
Menu.destroy_all
Section.destroy_all
Item.destroy_all
Modifier.destroy_all
ModifierGroup.destroy_all

# Create Menus
menus = Menu.create!([
  { identifier: 'menu_1', label: 'Breakfast Menu', state: 'active', start_date: Date.today, end_date: Date.today + 30 },
  { identifier: 'menu_2', label: 'Lunch Menu', state: 'inactive', start_date: Date.today, end_date: Date.today + 30 },
  { identifier: 'menu_3', label: 'Dinner Menu', state: 'pending', start_date: Date.today, end_date: nil }
])

# Create Sections
sections = Section.create!([
  { identifier: 'section_1', label: 'Starters', description: 'Appetizers to start your meal' },
  { identifier: 'section_2', label: 'Main Course', description: 'Hearty main dishes' },
  { identifier: 'section_3', label: 'Desserts', description: 'Sweet treats to finish your meal' }
])

# Create Items
items = Item.create!([
  { identifier: 'item_1', label: 'Caesar Salad', description: 'Fresh romaine lettuce with Caesar dressing', price: 7.99, type: 'Product' },
  { identifier: 'item_2', label: 'Grilled Chicken', description: 'Juicy grilled chicken breast', price: 12.99, type: 'Product' },
  { identifier: 'item_3', label: 'Chocolate Cake', description: 'Rich chocolate cake with cream', price: 5.99, type: 'Product' }
])

# Create Modifier Groups
modifier_groups = ModifierGroup.create!([
  { identifier: 'group_1', label: 'Dressings', selection_required_min: 0, selection_required_max: 1 },
  { identifier: 'group_2', label: 'Sides', selection_required_min: 1, selection_required_max: 3 }
])

# Create Modifiers
modifiers = Modifier.create!([
  { item: items[0], modifier_group: modifier_groups[0], display_order: 1, default_quantity: 1, price_override: nil }, # Dressings for Caesar Salad
  { item: items[1], modifier_group: modifier_groups[1], display_order: 1, default_quantity: 1, price_override: nil }  # Sides for Grilled Chicken
])

# Create Menu Sections
menu_sections = MenuSection.create!([
  { menu: menus[0], section: sections[0], display_order: 1 }, # Breakfast Menu includes Starters
  { menu: menus[0], section: sections[1], display_order: 2 }, # Breakfast Menu includes Main Course
  { menu: menus[1], section: sections[1], display_order: 1 }, # Lunch Menu includes Main Course
  { menu: menus[1], section: sections[2], display_order: 2 }  # Lunch Menu includes Desserts
])

# Create Section Items
section_items = SectionItem.create!([
  { section: sections[0], item: items[0], display_order: 1 }, # Starters section includes Caesar Salad
  { section: sections[1], item: items[1], display_order: 1 }, # Main Course section includes Grilled Chicken
  { section: sections[2], item: items[2], display_order: 1 }  # Desserts section includes Chocolate Cake
])

# Create Item Modifier Groups
item_modifier_groups = ItemModifierGroup.create!([
  { item: items[0], modifier_group: modifier_groups[0] }, # Caesar Salad with Dressings
  { item: items[1], modifier_group: modifier_groups[1] }  # Grilled Chicken with Sides
])

puts "Seed data created successfully!"
