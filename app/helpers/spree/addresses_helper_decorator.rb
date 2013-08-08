module Spree
  AddressesHelper.class_eval do
  	def address_field(form, method, id_prefix = "b", &handler)
	    id_prefix = id_prefix == 'bill_address' ? 'b' : 's'
	    content_tag :div, :id => [id_prefix, method].join, :class => "field row-fluid" do
	      if handler
	        handler.call
	      else
	      	html = ""
	        is_required = Spree::Address.required_fields.include?(method)
	        separator = is_required ? '<span class="required">*</span><br />' : '<br />'
	        html += content_tag :div, class: :span3 do
	        	form.label(method) + separator.html_safe 
	        end
	        html += content_tag :div, class: :span9 do
	        	form.text_field(method, :class => is_required ? 'required' : nil)
	        end
	        html.html_safe
	      end
	    end
	  end

	  def address_state(form, country)
	    country ||= Spree::Country.find(Spree::Config[:default_country_id])
	    have_states = !country.states.empty?
	    state_elements = [
	    	"<div class='span9'>",
	      form.collection_select(:state_id, country.states.order(:name),
	                            :id, :name,
	                            {:include_blank => true},
	                            {:class => have_states ? "required" : "hidden",
	                            :disabled => !have_states}) +
	      form.text_field(:state_name,
	                      :class => !have_states ? "required" : "hidden",
	                      :disabled => have_states),
	      "</div>"
	      ].join.gsub('"', "'").gsub("\n", "")
	      content_tag :div, class: "row-fluid" do
		      html = ""
		    	html += content_tag :div, class: [:span3, :statecon] do
		    		form.label(:state, t(:state)) + '<span class="req">*</span><br />'.html_safe
		    	end
		      html += content_tag(:noscript, form.text_field(:state_name, :class => 'required span9')) 	
		      html += javascript_tag("document.write(\"#{state_elements.html_safe}\");")
		      html.html_safe
		    end
	  end
  end
end