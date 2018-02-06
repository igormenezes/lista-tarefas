class ListController < ApplicationController
	def show
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
					@task.name = value
					@task.list_id = List.last.id + 1
					@arrayTasks << @task

					if !@task.valid?
						@error = true
					end
				end
			else
				@error = true
			end

			if !@error.nil?
				return render :show
			else
				@list.save

				@arrayTasks.each do | task |
					task.save
				end
				
				redirect_to root_url
			end
		rescue => e
			flash[:warning] = "Ocorreu um erro, ao tentar adicionar a lista! Erro: #{e}"
	    	return render :show
		end
	end
end
