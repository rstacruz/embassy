class Main
  migration "v0.0.1 create tables" do
    # Skip table creation if old tables are found.
    if database.tables == [:migrations]
      database.create_table :categories do
        primary_key :id

        String :name
      end

      database.create_table :users do
        primary_key :id

        String :profile_id

        text :email
        text :crypted_password

        Numeric :level
      end

      database.create_table :profiles do
        String :id, primary_key: true

        foreign_key :user_id

        String :display_name
      end

      database.create_table :projects do
        primary_key :id

        foreign_key :profile_id
      end

      database.create_table :images do
        primary_key :id

        String :filename
      end

      database.create_table :images_profiles do
        foreign_key :profile_id
        foreign_key :image_id
      end

      database.create_table :images_projects do
        foreign_key :profile_id
        foreign_key :project_id
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

  migration "v0.0.1 reseed categories" do
    Main.reload_models!
    Category.update_data!
  end

  migration "v0.0.1 projects" do
    database.alter_table :projects do
      add_column :name, String
    end
  end

  migration "v0.0.1 profile" do
    database.alter_table :profiles do
      add_column :location, String
      add_column :website, String

      add_column :biography, String

      add_column :dribbble, String
      add_column :twitter, String
      add_column :behance, String
    end
  end
end

