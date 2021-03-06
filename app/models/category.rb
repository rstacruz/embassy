class Category < Sequel::Model
  many_to_many  :profiles,
    left_id:    :category_id,
    right_id:   :profile_id,
    join_table: :categories_profiles

  many_to_many  :projects,
    left_id:    :category_id,
    right_id:   :project_id,
    join_table: :categories_projects

  def self.update_data!
    Main.seed.categories.sort.each do |name|
      Category.create name: name
    end
  end

  def self.[](id)
    super(id.to_i) || first(name: id)
  end

  # ----------------------------------------------------------------------------
  # Attributes

  def title
    default = name.gsub('_', ' ').capitalize
    I18n::t(name, scope: 'categories', default: default)
  end

  def to_param
    name
  end
end
