# A project.
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

  many_to_one   :profile

  # ----------------------------------------------------------------------------
  # Validations
  
  def validate
    validates_presence :name
    errors.add(:categories, 'must have at least one')  if new? && self.category_ids.empty?
  end

  # ----------------------------------------------------------------------------
  # Attributes
  
  def category_hash=(hash)
    ids = hash.select { |_, v| v == "1" }.keys
    @category_ids = ids
  end

  def category_ids
    @category_ids ||= if new?
      Array.new
    else
      categories.map(&:id)
    end
  end

  # ----------------------------------------------------------------------------
  # Hooks

  def after_save
    if category_ids.sort != categories.map(&:id).sort
      remove_all_categories
      category_ids.each { |id| add_category Category[id] }
    end
  end
end
