# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
      # Using Ruby on Rails

- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Recipes) 
      # User has_many projects

- [x] Include at least one belongs_to relationship (x belongs_to y e.g. Post belongs_to User)
      # Task belongs_to Project

- [x] Include at least one has_many through relationship (x has_many y through z e.g. Recipe has_many Items through Ingredients)
      # User has_many collaboration_projects through UserProjects, Project has_many collaborators through UserProjects

- [x] The "through" part of the has_many through includes at least one user submittable attribute (attribute_name e.g. ingredients.quantity)
      # UserProject attribute Permission

- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
      # Models validate presence of name and description, Tag validates uniqueness

- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
      # Projects complete/active/overudue scopes (eg projects/complete-projects)

- [x] Include a nested form writing to an associated model using a custom attribute writer (form URL, model name e.g. /recipe/new, Item)
      # Create new tags for a Task when creating/updating a Task

- [x] Include signup (how e.g. Devise)
      # Devise

- [x] Include login (how e.g. Devise)
      # Devise

- [x] Include logout (how e.g. Devise)
      # Devise
- [x] Include third party signup/login (how e.g. Devise/OmniAuth)
      # Devise /omniauth, provider: facebook

- [x] Include nested resource show or index (URL e.g. users/2/recipes)
      # Nested resources for projects/2/tasks, comments, notes

- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients)
      # Nested resources for projects, eg projects/2/tasks/new

- [x] Include form display of validation errors (form URL e.g. /recipes/new)
      # validation errors appear above form when submitting invalid data

Confirm:
- [x] The application is pretty DRY
      # I tried to abstract as much of the details into reusable methods

- [x] Limited logic in controllers
      # I tried to abstract as much of the details into reusable methods in models, except for methods that don't appear frequently

- [x] Views use helper methods if appropriate
      # Didn't use any view helpers
      
- [x] Views use partials if appropriate
      # Lots of partials to keep things organized