## Setup and Start the Application

### Prerequisites

- Ruby (version 3.0 or higher)
- Rails (version 7.0 or higher)
- PostgreSQL
- GraphQL

### Installation Steps

1. **Clone the repository:**
   ```bash
   git clone https://github.com/rising-stark/grain_menu_app
   cd grain_menu_app
   ```

2. **Install dependencies:**
   ```bash
   bundle install
   ```

3. **Configure the database:**
   - Create a PostgreSQL database and update the `config/database.yml` file with your database credentials.
   - Run the following command to create and set up the database:
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. **Start the Rails server:**
   ```bash
   rails server
   ```

5. **Access the application:**
   Open your web browser and go to `http://localhost:3000`.

## Sample GraphQL Requests

### Query Requests

Fetch All Menus
```graphql
{
  menus {
    identifier
    label
    state
    start_date
    end_date
    sections {
      identifier
      label
    }
  }
}
```

Fetch a Specific Menu
```graphql
{
  menu(input: { identifier: "your_menu_identifier" }) {
    identifier
    label
    state
    start_date
    end_date
    sections {
      identifier
      label
    }
  }
}
```

Fetch All Sections
```graphql
{
  sections {
    identifier
    label
    description
  }
}
```

Fetch a Specific Section
```graphql
{
  section(input: { identifier: "your_section_id" }) {
    identifier
    label
    description
  }
}
```

Fetch All Items
```graphql
{
  items {
    identifier
    label
    description
    price
  }
}
```

Fetch a Specific Item
```graphql
{
  item(input: { identifier: "your_item_id" }) {
    identifier
    label
    description
    price
  }
}
```

Fetch All Modifier Groups
```graphql
{
  modifier_groups {
    identifier
    label
    selection_required_min
    selection_required_max
  }
}
```

Fetch a Specific Modifier Group
```graphql
{
  modifier_group(input: { identifier: "your_modifier_group_id" }) {
    identifier
    label
    selection_required_min
    selection_required_max
  }
}
```

Fetch All Modifiers
```graphql
{
  modifiers {
    identifier
    display_order
    price_override
  }
}
```

Fetch a Specific Modifier
```graphql
{
  modifier(input: { identifier: "your_modifier_id" }) {
    identifier
    display_order
    price_override
  }
}
```

### Mutation Requests

Create a Menu
```graphql
mutation {
  createMenu(input: { identifier: "menu_001", label: "Menu 1", state: "active", start_date: "2024-10-15", end_date: "2024-12-15" }) {
    menu {
      identifier
      label
    }
  }
}
```

Update a Menu
```graphql
mutation {
  updateMenu(input: { identifier: "menu_001", label: "Updated Menu 1", state: "inactive" }) {
    menu {
      identifier
      label
    }
  }
}
```

Delete a Menu
```graphql
mutation {
  deleteMenu(input: { identifier: "menu_001" }) {
    success
  }
}
```

Create a Section
```graphql
mutation {
  createSection(input: { identifier: "section_001", label: "Section 1", description: "First Section" }) {
    section {
      identifier
      label
    }
  }
}
```

Update a Section
```graphql
mutation {
  updateSection(input: { identifier: "section_001", label: "Updated Section 1" }) {
    section {
      identifier
      label
    }
  }
}
```

Delete a Section
```graphql
mutation {
  deleteSection(input: { identifier: "section_001" }) {
    success
  }
}
```

Create an Item
```graphql
mutation {
  createItem(input: { identifier: "item_001", label: "Item 1", description: "First Item", price: 9.99, type: "food" }) {
    item {
      identifier
      label
    }
  }
}
```

Update an Item
```graphql
mutation {
  updateItem(input: { identifier: "item_001", label: "Updated Item 1", price: 10.99 }) {
    item {
      identifier
      label
    }
  }
}
```

Delete an Item
```graphql
mutation {
  deleteItem(input: { identifier: "item_001" }) {
    success
  }
}
```

Create a Modifier Group
```graphql
mutation {
  createModifierGroup(input: { identifier: "modifier_group_001", label: "Modifier Group 1", selection_required_min: 1, selection_required_max: 3 }) {
    modifier_group {
      identifier
      label
    }
  }
}
```

Update a Modifier Group
```graphql
mutation {
  updateModifierGroup(input: { identifier: "modifier_group_001", label: "Updated Modifier Group 1" }) {
    modifier_group {
      identifier
      label
    }
  }
}
```

Delete a Modifier Group
```graphql
mutation {
  deleteModifierGroup(input: { identifier: "modifier_group_001" }) {
    success
  }
}
```

Create a Modifier
```graphql
mutation {
  createModifier(input: { item_identifier: "item_001", modifier_group_identifier: "modifier_group_001", display_order: 1, default_quantity: 1 }) {
    modifier {
      identifier
      item_identifier
      modifier_group_identifier
    }
  }
}
```

Update a Modifier
```graphql
mutation {
  updateModifier(input: { item_identifier: "item_001", modifier_group_identifier: "modifier_group_001", display_order: 2 }) {
    modifier {
      identifier
      item_identifier
      modifier_group_identifier
    }
  }
}
```

Delete a Modifier
```graphql
mutation {
  deleteModifier(input: { item_identifier: "item_001", modifier_group_identifier: "modifier_group_001" }) {
    success
  }
}
```

## Pending
1. **Update/create nested obejcts**: Allow creating/updating nested obejcts.
