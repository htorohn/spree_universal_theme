class Spree::StoreController
	before_action :load_taxonomies
	before_action :load_latest_products
	before_action :load_best_sellers
		

	def load_taxonomies
		@taxonomies = Spree::Taxonomy.includes(root: :children)
	end
	
    def load_latest_products
	    @latest_products = Spree::Product.available.order('available_on DESC').distinct.limit(10);
	    #render "index"
	    #@latest_products = (Spree::Product.latest_products rescue nil)
	end
	
	def load_best_sellers
	    # config = Spree::BestSellersConfiguration.new
	    # if ((config.has_preference?(:show_best_sellers) && config[:show_best_sellers]) || (config.has_preference?(:show_best_sellers_sidebar) && config[:show_best_sellers_sidebar]))
	    @best_sellers = (Spree::Product.best_sellers rescue nil)
	    # end
	end

end