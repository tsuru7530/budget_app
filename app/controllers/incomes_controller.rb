class IncomesController < ApplicationController
    def new
        @income = Income.new
    end

    def create
        Income.create(income_params)
        redirect_to root_path
    end

    def edit
        @income = Income.find(params[:id])
    end

    def update
        Income.update(income_params)
        redirect_to root_path
    end
    
    private
    def income_params
        params.require(:income).permit(:district_id, :year, :category, :price)
    end
end
