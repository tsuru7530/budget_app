class OutgoesController < ApplicationController
    def new
        @outgo = Outgo.new
    end

    def create
        Outgo.create(outgo_params)
        redirect_to root_path
    end

    def edit
        @outgo = Outgo.find(params[:id])
    end

    def update
        Outgo.update(outgo_params)
        redirect_to root_path
    end

    private
    def outgo_params
        params.require(:outgo).permit(:income_id, :year, :category, :price, :memo)
    end
end
