class Main
  migration "v0.0.2 create tables" do
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

  migration "v0.0.2 reseed categories" do
    Main.reload_models!
    Category.update_data!
  end

  migration "v0.0.2 images_projects typo" do
    database.alter_table :images_projects do
      rename_column :profile_id, :image_id
    end
  end
end

