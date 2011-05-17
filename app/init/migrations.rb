class Main
  migration "v0.0.3 create tables" do
    # Skip table creation if old tables are found.
    if database.tables == [:migrations]
      database.create_table :categories do
        primary_key :id

        String :name
      end

      database.create_table :users do
        primary_key :id
        foreign_key :profile_id

        text :email
        text :crypted_password

        Numeric :level
      end

      database.create_table :profiles do
        primary_key :id
        foreign_key :user_id

        String :name
        String :display_name

        String :location
        String :website

        String :biography

        String :dribbble
        String :twitter
        String :behance
      end

      database.create_table :projects do
        primary_key :id
        foreign_key :profile_id

        String :name
      end

      database.create_table :images do
        primary_key :id
        foreign_key :profile_id
        foreign_key :project_id

        String :filename
      end

      database.create_table :categories_profiles do
        foreign_key :category_id
        foreign_key :profile_id
      end

      database.create_table :categories_projects do
        foreign_key :category_id
        foreign_key :project_id
      end
    end
  end

  migration "v0.0.3 reseed categories" do
    Main.reload_models!
    Category.update_data!
  end
end

