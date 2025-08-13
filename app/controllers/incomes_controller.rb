class IncomesController < ApplicationController
    before_action :set_income, only:[:show, :edit, :update, :destroy]
    
    def new
        @income = Income.new
    end

    def show
        @outgoes = @income.outgoes
        @total = @income.price
        @outgoes.each do |outgo|
            @total -= outgo.price
        end
    end

    def create
        district_id = income_params[:district_id]
        @income = Income.new(income_params)
        if @income.save
            redirect_to district_path(@income.district)
        else
            render :new, status: :unprocessable_entity 
        end
    end

    def edit
    end

    def update
        if @income.update(income_params)
            redirect_to income_path(@income)
        else
            render :edit, status: :unprocessable_entity 
        end
    end

    def destroy
        district = @income.district
        @income.destroy
        redirect_to district_path(district)
    end
    
    private
    def income_params
        params.require(:income).permit(:district_id, :year, :category, :price, :memo)
    end

    def set_income
        @income = Income.find(params[:id])
    end
end
