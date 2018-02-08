class ListController < ApplicationController
	def show
		flash.delete(:warning)
		@lists = List.select(:id, :name, :available)
		.where('lists.user_id = ? AND active = ?', current_user.id, 1)
	end

	def new
		flash.delete(:warning)
	end

	def add
		begin
			@error = nil
			@arrayTasks = []
			values = params.require(:list).permit :name, :available
			values[:user_id] = current_user.id

			@list = List.new values

			if @list.valid?
				params[:task].each do | value|
					@task = Task.new
					@task.description = value
					@task.list_id = List.maximum('id').nil? ? 1 : List.maximum('id') + 1
					@arrayTasks << @task

					if !@task.valid?
						@error = true
					end
				end
			else
				@error = true
			end

			if !@error.nil?
				return render :new
			else
				@list.save

				@arrayTasks.each do | task |
					task.save
				end

				redirect_to root_url
			end
		rescue => e
			flash[:warning] = "Ocorreu um erro, ao tentar adicionar a lista! Erro: #{e}"
			return render :new
		end
	end

	def all
		begin
			@lists = List.select(:id, :name)
			.joins('LEFT JOIN tasks ON tasks.list_id = lists.id')
			.joins('LEFT JOIN favorites ON favorites.list_id = lists.id')
			.where('lists.available = ? AND lists.user_id <> ? AND (favorites.user_id <> ? OR favorites.user_id IS NULL)', 1, current_user.id, current_user.id)
			.group(:id)

			@tasks = Task.select(:id, :description, :list_id)
			.joins('LEFT JOIN lists ON lists.id = tasks.list_id')
			.joins('LEFT JOIN favorites ON favorites.list_id = lists.id')
			.where('lists.available = ? AND lists.user_id <> ? AND (favorites.user_id <> ? OR favorites.user_id IS NULL)', 1, current_user.id, current_user.id)
		rescue => e
			flash[:warning] = "Ocorreu um erro, ao tentar adicionar a lista! Erro: #{e}"
			return render :new
		end
	end
end
