class DistrictsController < ApplicationController
    before_action :set_district, only:[:show, :edit, :update, :destroy]
    def index
        @districts = District.all.page(params[:page]).per(10)
        gon.districts = @districts
    end

    def show
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
        gon.latitude = @district.latitude
        gon.longitude = @district.longitude
    end

    def update
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
        @district.destroy
        redirect_to root_path
    end

    def search
        if params[:category] == "地区名"
            @districts = District.where("name LIKE ?", "%#{params[:inputword]}%").page(params[:page]).per(10)
        elsif params[:category] == "年度"
            @districts = District.where("year LIKE ?", "%#{params[:inputword]}%").page(params[:page]).per(10)
        else
            @districts = District.where("office LIKE ?", "%#{params[:inputword]}%").page(params[:page]).per(10)
        end
    end

    private
    def district_params
        params.require(:district).permit(:name, :year, :office, :image, :image_delete, :latitude, :longitude)
    end

    def set_district
        @district = District.find(params[:id])
    end
end
