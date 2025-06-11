class IncomesController < ApplicationController
    def new
        @income = Income.new
    end

    def show
        @income = Income.find(params[:id])
        @outgoes = @income.outgoes
        @total = @income.price
        @outgoes.each do |outgo|
            @total -= outgo.price
        end
    end

    def create
        district_id = income_params[:district_id]
        Income.create(income_params)
        redirect_to district_path(district_id)
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
        params.require(:income).permit(:district_id, :year, :category, :price, :memo)
    end
end
