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
      Spree::Review.approved.last(5)
    end

    def social_network_link network
      network_link = Spree::Config.get("#{network}_url")
      if network_link
        return link_to Spree.t(network), network_link, class: network, target: "_blank"
      end
    end

    def taxon_subnav taxon
      html = ""
      if taxon.children.any?
        html += content_tag :li, class: 'parent' do
          nonbreaking(taxon.name)
        end
        taxon.children.each do |child| 
          html += content_tag :li do
            link_to nonbreaking(child.name), seo_url(child)
          end
        end
      else
        html += content_tag :li, class: 'parent' do
          link_to(nonbreaking(taxon.parent.name), seo_url(taxon.parent))
        end
        taxon.parent.children.each do |t|
          html += content_tag :li do
            t == taxon ? nonbreaking(t.name) : link_to(nonbreaking(t.name), seo_url(t))
          end
        end
      end
      html.html_safe
    end

    def should_be_active taxon, category
      if (category == taxon) || (taxon && taxon.ancestors.include?(category))
        "active"
      end
    end

    def create_product_image_tag(image, product, options, style)
      options.reverse_merge! alt: image.alt.blank? ? product.name : image.alt
      image_tag image.attachment.url(style), options
    end

    def nonbreaking text
      text
    end
  end
end
