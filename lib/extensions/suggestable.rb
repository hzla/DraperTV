module Extensions
	module Suggestable
		def suggested
    		Video.tagged_with(category_list, any: true).limit(10)
  		end
	end
end