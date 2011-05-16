require_relative 'has_categories'

# A project.
class Project < Sequel::Model
  include HasCategories

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

  many_to_one   :profile

  # ----------------------------------------------------------------------------
  
  def to_param
    "#{id.to_i}-#{slugify(name)}"
  end

  # ----------------------------------------------------------------------------
  # Validations
  
  def validate
    validates_presence :name
    errors.add(:category_names, 'must have at least one')  if new? && self.category_names.empty?
  end

private
  def slugify(str)
    str.scan(/[A-Za-z0-9]+/).join('_').downcase
  end
end
