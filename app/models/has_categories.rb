# Has categories.
#
# == Usage
#
#   class MyModel
#     include HasCategories
#   end
#
#   re = MyModel.new
#   re.category_hash = { alpha: "0", bravo: "1" }
#   re.category_names  #=> ['alpha', 'bravo']
#   re.save
#
#   re.categories  #=> [Category['alpha'], Category['bravo']]
#
module HasCategories
  def categories_hash=(hash)
    names = hash.select { |_, v| v == "1" }.keys.map(&:to_s)
    self.category_names = names
  end

  def category_names
    @category_names ||= if new?
      Array.new
    else
      categories.map(&:name).map(&:to_s)
    end
  end

  def category_names=(v)
    @category_names = v
  end

  # Picks the topmost 3 categories.
  def main_categories
    categories.to_a[0..3]
  end

  # Returns a list of category titles.
  # (eg: +["Web development", "Design"]+)
  def category_titles
    categories.map(&:title)
  end

  # Returns a list of category titles for the top 3 cats.
  def main_category_titles
    main_categories.map(&:title)
  end

  def categories?
    categories.any?
  end

  # ----------------------------------------------------------------------------
  # Hooks

  def after_save
    super

    if category_names.sort != categories.map(&:name).sort
      remove_all_categories
      category_names.each { |id| add_category Category[id] }
    end
  end
end
