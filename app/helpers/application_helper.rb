module ApplicationHelper
	#return a title based on page basis
	def title
		base_title = "Ruby on rails tutorial : sample app"
		if @title.nil?
			base_title
		else
		"#{base_title}| #{@title}"
		end
	end
	def logo
		image_tag("logo.png", :alt => "Sample app", :class => "round")
	end
end
