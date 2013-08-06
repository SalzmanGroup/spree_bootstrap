Deface::Override.new(:virtual_path => "spree/products/show",
                     :name => "converted_product_properties_767643482",
                     :insert_after => "[data-hook='related_products']",
                     :partial => "spree/shared/reviews",
                     :disabled => false)


Deface::Override.new(:virtual_path => "spree/reviews/new",
                     :name => "addNewReviews",
                     :insert_after => "[data-hook='related_products']",
                     :partial => "spree/shared/reviews",
                     :disabled => false)
