# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	def is_mobile?
		return /(\b(iphone|ipod|ipad|android)\b)|(W3C-mobile)/i.match(request.env["HTTP_USER_AGENT"])
	end
	
	def is_W3C_validator?
		return /(W3C_Validator|W3C-mobile)/i.match(request.env["HTTP_USER_AGENT"])
	end
end
