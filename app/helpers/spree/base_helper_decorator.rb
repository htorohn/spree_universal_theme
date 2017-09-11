module Spree::BaseHelper
   
    
    def layout_partial
        if devise_controller?
          #@taxonomies = Spree::Taxonomy.includes(root: :children)
          'spree/base/devise'
        else
          @taxonomies = Spree::Taxonomy.includes(root: :children)
          'spree/base/application'
        end
      end
    
    
    def logo(image_path = Spree::Config[:logo], a_options: {}, img_options: {})
        link_to spree.root_path, a_options do
            image_tag(image_path, img_options)
        end
    end
   
    def nav_tree(root_taxon, current_taxon, max_level = 1)
        return '' if max_level < 1 || root_taxon.children.empty?
        content_tag :ul, class: 'dropdown-menu' do
            content_tag :div, class: "row" do 
              #content_tag :div, class: "col-sm-3" do
              #end
              content_tag :div, class: "col-sm-6 col-sm-offset-3" do
                content_tag :ul, class: "multi-column-dropdown" do
                  taxons = root_taxon.children.map do |taxon|
                      css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'active' : nil
                      #content_tag :li, class: css_class do
                          #content_tag :div, class: "yamm-content" do   
                              #content_tag :ul do
                                  
                                  content_tag :li, link_to(taxon.name, seo_url(taxon)) +
                                      taxons_tree(taxon, current_taxon, max_level - 1)
                              #end
                          #end
                      #end
                  end
                  safe_join(taxons, "\n")
                end
              end
              #content_tag :div, class: "col-sm-3" do
              #end
            end
            
        end
    end
    
    def footer_tree(root_taxon, current_taxon, max_level = 1)
        return '' if max_level < 1 || root_taxon.children.empty?
        content_tag :ul do
            taxons = root_taxon.children.map do |taxon|
                css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'active' : nil
   
                    content_tag :li, link_to(taxon.name, seo_url(taxon)) +
                        taxons_tree(taxon, current_taxon, max_level - 1)
            end

            safe_join(taxons, "\n")
        end
    end
    
    def link_to_cart_obaju(text = nil)
      text = text ? h(text) : Spree.t('cart')
      css_class = nil

      if simple_current_order.nil? or simple_current_order.item_count.zero?
        text = "<span class='glyphicon glyphicon-shopping-cart'></span> #{text}: (#{Spree.t('empty')})"
        css_class = 'empty'
      else
        text = "<span class='glyphicon glyphicon-shopping-cart'></span> #{text}: (#{simple_current_order.item_count})  <span class='amount'>#{simple_current_order.display_total.to_html}</span>"
        css_class = 'full'
      end

      #link_to text.html_safe, spree.cart_path, class: "cart-info #{css_class}"
      link_to text.html_safe, spree.cart_path, class: "btn btn-primary navbar-btn #{css_class}"
    end

   
end