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
        income = Income.create(income_params)
        redirect_to district_path(income.district)
    end

    def edit
        @income = Income.find(params[:id])
    end

    def update
        @income = Income.find(params[:id])
        @income.update(income_params)
        redirect_to income_path(@income)
    end

    def destroy
        @income = Income.find(params[:id])
        district = @income.district
        @income.destroy
        redirect_to district_path(district)
    end
    
    private
    def income_params
        params.require(:income).permit(:district_id, :year, :category, :price, :memo)
    end
end
