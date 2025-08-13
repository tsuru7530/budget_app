class OutgoesController < ApplicationController
    before_action :set_outgo, only:[:edit, :update, :destroy]
    before_action :set_income, only:[:new, :create, :edit, :update]
    
    def new
        @outgo = Outgo.new
    end

    def create
        @outgo = Outgo.new(outgo_params)
        if @outgo.save
            redirect_to income_path(@income)
        else
            render :new, status: :unprocessable_entity 
        end
    end

    def edit
    end

    def update
        if @outgo.update(outgo_params)
            redirect_to income_path(@income)
        else
            render :edit, status: :unprocessable_entity 
        end
    end

    def destroy
        income= @outgo.income
        @outgo.destroy
        redirect_to income_path(income)
    end

    private
    def outgo_params
        params.require(:outgo).permit(:income_id, :year, :price, :memo)
    end

    def set_income
        @income = Income.find(params[:income_id])
    end

    def set_outgo
        @outgo = Outgo.find(params[:id])
    end
end
