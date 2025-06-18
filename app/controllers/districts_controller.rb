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
        @district = District.new(district_params)
        if @district.save
            redirect_to root_path
        else
            render :new, status: :unprocessable_entity 
        end
    end

    def edit
        @district = District.find(params[:id])
    end

    def update
        @district = District.find(params[:id])
        if @district.update(district_params)
            redirect_to root_path
        else
            render :edit, status: :unprocessable_entity 
        end
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
        params.require(:district).permit(:name, :year, :office)
    end
end
