module ApplicationHelper
	#return a title based on page basis
	def title
		base_title = "Stitch me: Website for women apperal"
		if @title.nil?
			base_title
		else
		"#{base_title}| #{@title}"
		end
	end
	def logo
		image_tag("logo.png", :alt => "Logo image", :id => "logo_img")
	end
	def banner
		image_tag("banner_home.png", :alt => "banner image", :id => "home_banner")
	end
	def cart
		image_tag("cart.png", :alt => "cart image")
	end
	def blank
		image_tag("blank.png", :alt => "cart image",:id => "home_banner")	
	end
end
