module Spree
  BaseHelper.class_eval do
    def breadcrumbs(taxon, separator="&nbsp;&raquo;&nbsp;")
      return "" if current_page?("/") || taxon.nil?
      separator = raw(separator)
      crumbs = [content_tag(:li, link_to(Spree.t(:home), spree.root_path) + separator)]
      if taxon
        crumbs << content_tag(:li, link_to(Spree.t(:products), products_path) + separator)
        crumbs << taxon.ancestors.collect { |ancestor| content_tag(:li, link_to(ancestor.name , seo_url(ancestor)) + separator) } unless taxon.ancestors.empty?
        crumbs << content_tag(:li, content_tag(:span, link_to(taxon.name , seo_url(taxon))))
      else
        crumbs << content_tag(:li, content_tag(:span, Spree.t(:products)))
      end
      crumb_list = content_tag(:ul, raw(crumbs.flatten.map{|li| li.mb_chars}.join), class: 'inline')
      content_tag(:nav, crumb_list, id: 'breadcrumbs', class: 'span12')
    end

    def get_categories
      top_level = Spree::Taxonomy.find_by_name('Categories').try(:taxons).to_a
      return top_level.any? ? top_level.first.children : []
    end

    def get_reviews
      Spree::Review.last(5)
    end

    def social_network_link network
      network_link = Rails.application.config.try(:social_networks).try(:[], network)
      if network_link
        return link_to Spree.t(network), network_link, class: network, target: "_blank"
      end
    end
  end
end
