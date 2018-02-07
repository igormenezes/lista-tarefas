class TaskController < ApplicationController
	def edit
		begin
			@tasks = Task.select(:id, :description, :active)
			.joins('LEFT JOIN lists ON lists.id = tasks.list_id')
			.where('lists.id = ? AND lists.user_id = ?', params[:id], current_user.id)
		rescue => e
			flash[:warning] = "Erro, ao tentar encontrar tarefas dessa lista, deste usuário! Erro: #{e}"
			return render :new
		end
	end

	def update
		begin
			if current_user.id != params[:user].to_i
				raise 'Usuário inválido'
			end

			Task.update(params[:id].to_i, active: 0)

			render json: {id: params[:id], success: true}
		rescue => e
			render json: {id: params[:id], success: false, message: "Erro ao tentar atualizar task #{e}"}
		end
	end
end
