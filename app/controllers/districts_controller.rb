class DistrictsController < ApplicationController
    def index
        @districts = District.all.page(params[:page])
    end

    def show
        @district = District.find(params[:id])
        gon.latitude = @district.latitude
        gon.longitude = @district.longitude
        @incomes = @district.incomes
    end

    def new
        @district = District.new
        @district.latitude = 35.681382
        @district.longitude = 139.766084
        gon.latitude = @district.latitude
        gon.longitude = @district.longitude
    end

    def create
        @district = District.new(district_params)
        if @district.image_delete == 1
            @district.image.purge unless @district.image.nil?
        end
        if @district.save
            redirect_to root_path
        else
            render :new, status: :unprocessable_entity 
        end
    end

    def edit
        @district = District.find(params[:id])
        gon.latitude = @district.latitude
        gon.longitude = @district.longitude
    end

    def update
        @district = District.find(params[:id])
        if @district.image_delete == 1
            @district.image.purge unless @district.image.nil?
        end
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
        if params[:category] == "地区名"
            @districts = District.where("name LIKE ?", "%#{params[:inputword]}%").page(params[:page])
        elsif params[:category] == "年度"
            @districts = District.where("year LIKE ?", "%#{params[:inputword]}%").page(params[:page])
        else
            @districts = District.where("office LIKE ?", "%#{params[:inputword]}%").page(params[:page])
        end
    end

    private
    def district_params
        params.require(:district).permit(:name, :year, :office, :image, :image_delete, :latitude, :longitude)
    end
end
