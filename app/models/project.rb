class Project < Sequel::Model
  many_to_one   :user,
    class:      :User

  many_to_many  :categories,
    left_id:    :project_id,
    right_id:   :category_id,
    join_table: :categories_projects

  many_to_many  :images,
    left_id:    :project_id,
    right_id:   :image_id,
    join_table: :images_projects
end
