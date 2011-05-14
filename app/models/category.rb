class Category < Sequel::Model
  many_to_many  :profiles,
    left_id:    :category_id,
    right_id:   :profile_id,
    join_table: :categories_profiles

  many_to_many  :projects,
    left_id:    :category_id,
    right_id:   :project_id,
    join_table: :categories_projects
end