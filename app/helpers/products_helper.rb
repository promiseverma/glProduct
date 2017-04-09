module ProductsHelper

	def get_piece(arr, id)
		arr.count{|x| x == id.to_s}
	end
end
