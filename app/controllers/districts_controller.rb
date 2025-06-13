class DistrictsController < ApplicationController
    def index
        @districts = District.all
    end

    def show
        @district = District.find(params[:id])
        @incomes = @district.incomes
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
        @district = District.find(params[:id])
        @district.update(district_params)
        redirect_to root_path
    end

    def destroy
        @district = District.find(params[:id])
        @district.destroy
        redirect_to root_path
    end

    def search
        @districts = District.where("name LIKE ?", "%#{params[:inputword]}%")
    end

    private
    def district_params
        params.require(:district).permit(:name)
    end
end
