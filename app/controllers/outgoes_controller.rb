class OutgoesController < ApplicationController
    def new
        @income = Income.find(params[:income_id])
        @outgo = Outgo.new
    end

    def create
        @income = Income.find(params[:income_id])
        Outgo.create(outgo_params)
        redirect_to income_path(@income)
    end

    def edit
        @income = Income.find(params[:income_id])
        @outgo = Outgo.find(params[:id])
    end

    def update
        @income = Income.find(params[:income_id])
        @outgo = Outgo.find(params[:id])
        @outgo.update(outgo_params)
        redirect_to income_path(@income)
    end

    def destroy
        @outgo = Outgo.find(params[:id])
        income= @outgo.income
        @outgo.destroy
        redirect_to income_path(income)
    end

    private
    def outgo_params
        params.require(:outgo).permit(:income_id, :year, :price, :memo)
    end
end
