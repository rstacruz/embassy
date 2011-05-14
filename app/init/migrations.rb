class Main
  migration "v0.0.1 create tables" do
    # Skip table creation if old tables are found.
    if database.tables == [:migrations]
      database.create_table :categories do
        String :id, primary_key: true

        String :name
      end

      database.create_table :users do
        primary_key :id

        text :email
        text :crypted_password

        Numeric :level
      end

      database.create_table :profiles do
        String :id, primary_key: true
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
end

