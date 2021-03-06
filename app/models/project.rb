require_relative 'has_categories'

# A project.
class Project < Sequel::Model
  include HasCategories

  many_to_one   :user
  many_to_one   :profile

  one_to_many   :images

  many_to_many  :categories,
    left_id:    :project_id,
    right_id:   :category_id,
    join_table: :categories_projects

  # ----------------------------------------------------------------------------
  
  def to_param
    "#{id.to_i}-#{slugify(name)}"
  end

  def main_image
    images.first
  end

  def has_image?
    ! main_image.nil?
  end

  # ----------------------------------------------------------------------------
  # Validations
  
  def validate
    validates_presence :name
    errors.add(:category_names, 'must have at least one')  if new? && self.category_names.empty?
  end

  # ----------------------------------------------------------------------------

  def before_destroy
    remove_all_images
  end

private
  def slugify(str)
    str.scan(/[A-Za-z0-9]+/).join('_').downcase
  end
end
