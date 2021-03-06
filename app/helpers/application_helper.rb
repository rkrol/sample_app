module ApplicationHelper
	def title
		base_title = "Sample App of Ruby on Rails Tutorial"
		if @title.nil?
		  base_title
		else
		  "#{base_title} | #{@title}"
		end
	end

	def logo
		image_tag("logo.png", :alt => "Sample application", :class => "round")
	end
end
