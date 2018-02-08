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

	def show
		begin
			@favorites = Favorite.select(:id, :list_id)
			.where('favorites.user_id = ?', current_user)

			@lists = List.select(:id, :name)
			.joins('LEFT JOIN tasks ON tasks.list_id = lists.id')
			.joins('LEFT JOIN favorites ON favorites.list_id = lists.id')
			.where('favorites.user_id = ?', current_user.id)
			.group(:id)

			@tasks = Task.select(:id, :description, :list_id)
			.joins('LEFT JOIN lists ON lists.id = tasks.list_id')
			.joins('LEFT JOIN favorites ON favorites.list_id = lists.id')
			.where('favorites.user_id = ?', current_user.id)
		rescue => e
			flash[:warning] = "Ocorreu um erro, ao exibir lista de favoritos! Erro: #{e}"
			return render :new
		end
	end

	def remove
		begin
			id = params[:id].to_i

			if id > 0
				Favorite.where('favorites.id = ? AND favorites.user_id = ?', id, current_user.id)
				.delete_all()
				
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