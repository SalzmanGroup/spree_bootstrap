module Spree
  ProductsHelper.class_eval do
    def stock_status variant
      if ["out_of_stock","preorder"].include?(variant_availability(variant))
        Spree.t variant_availability(variant)
      end
    end

    def variant_availability variant
      unless variant.stock_items.sum {|s| s.count_on_hand } > 0
        if variant.stock_items.map(&:backorderable?).include? (true)
          "preorder"
        else
          "out_of_stock"
        end
      else
        "in_stock"
      end
    end  
  end
end
