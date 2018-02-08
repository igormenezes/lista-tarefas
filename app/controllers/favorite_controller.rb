class FavoriteController < ApplicationController
	def add
		begin
			id = params[:id].to_i

			if id > 0
				favorite = Favorite.new(list_id: id, user_id: current_user.id)
				favorite.save
				render json: {id: id, success: true}
			else
				raise 'Parametro inválido'
			end
		rescue => e
			render json: {
				id: params[:id], 
				success: false, 
				message: "Erro ao tentar adicionar lista nos favoritos: #{e}"
			}
		end
	end
end
