class DistrictsController < ApplicationController
    def index
        @districts = District.all
    end

    def show
        @district = District.find(params[:id])
        @incomes = @district.incomes
        @outgoes = @district.outgoes
        @total = 0
    end

    def new
        @district = District.new
    end

    def create
        District.create(district_params)
        redirect_to root_path
    end

    def edit
        @district = District.find(params[:id])
    end

    def update
        District.update(district_params)
        redirect_to root_path
    end

    private
    def district_params
        params.require(:district).permit(:name)
    end
end
