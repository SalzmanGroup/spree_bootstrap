module Spree
  ProductsHelper.class_eval do
    def get_categories
      top_level = Spree::Taxonomy.find_by_name('Categories').try(:taxons).to_a
      if top_level.length
        return top_level.first.children
      end
    end

    def get_reviews
      Spree::Review.last(5)
    end 
  end
end