Deface::Override.new(:virtual_path => "spree/admin/shared/_configuration_menu",
                     :name => "add_pages_to_admin_configuration_sidebar",
                     :insert_bottom => "[data-hook='admin_configurations_sidebar_menu'], #admin_configurations_sidebar_menu[data-hook]",
                     :text => "<%= configurations_sidebar_menu_item Spree.t('spree_pages.pages_settings'), admin_pages_path %>",
                     :disabled => false)
