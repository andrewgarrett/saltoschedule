class EquipmentsController < ApplicationController
    before_action :authenticate_user!, only: [:index, :new, :edit ]
    def index
      @equipments = current_user.equipments
    end

    def show
      @equipment = Equipment.find(params[:id])
    end

    def new
      #@equipment = current_user.equipments.new
      @equipment = current_user.equipments.new
    end

    def edit
      @equipment = Equipment.find(params[:id])
    end

    def create

      @equipment = Equipment.new(equipment_params)
      @equipment.user_id = current_user.id
      if @equipment.save
        redirect_to equipments_path
      else
        render action: :new
      end
    end

    def update
      @equipment = Equipment.find(params[:id])
      if @equipment.update_attributes(equipment_params)
        redirect_to equipments_path
      else
        render action: :edit
      end
    end

    def destroy
        Equipment.find(params[:id]).destroy
        redirect_to equipments_path
    end

    private
    def equipment_params
      params.require(:equipment).permit(:name, :max_class, :user_id, :desc)
    end
end
