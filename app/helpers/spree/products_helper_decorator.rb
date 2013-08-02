module Spree
  ProductsHelper.class_eval do
    def get_categories
      top_level = Spree::Taxonomy.find_by_name('Categories').try(:taxons).to_a
      if top_level.length
        return top_level.first.children
      end
    end

    def subcategory_tree category
      if category.children.any?

      end
    end
  end
end