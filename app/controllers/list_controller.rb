class ListController < ApplicationController
	def show
	end

	def add
		begin
			values = params.require(:list).permit :name, :available
			@list = List.new values
			if @list.save
				redirect_to root_url	
			else
				render :show
			end
		rescue => e
			flash[:warning] = "Ocorreu um erro, ao tentar adicionar a lista! Erro: #{e}"
	    	return render :show
		end
	end
end
