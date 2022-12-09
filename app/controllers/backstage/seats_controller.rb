class Backstage::SeatsController < Backstage::ManagersController
  
    before_action :find_restaurant_id, only: [:new, :create]
    before_action :find_seat, only: [:show, :edit, :update, :destroy]
  
    def new
      @seat = @restaurant.seats.new
    end
  
    def create
      @seat = @restaurant.seats.new(params_seat)

      if @seat.save
        redirect_to backstage_restaurant_path(@restaurant), notice: "成功新增位子類型"
      else
        render :new
      end
    end
  
    def show
      
    end
  
    def edit
    end
  
    def update
      if @seat.update(params_seat)
        redirect_to backstage_restaurant_path(@seat.restaurant), notice: "編輯seat成功"
      else
        render :edit
      end
    end
  
    def destroy
      @seat.destroy
      redirect_to backstage_restaurant_path(@seat.restaurant), alert: "刪除seat成功"
    end
  
    private
  
    def find_restaurant_id
      @restaurant = Restaurant.find_by!(id: params[:restaurant_id])
    end
  
    def params_seat
      params.require(:seat).permit(:kind, :capacity, :deposit, :state)
    end
  
    def find_seat
      @seat = Seat.find_by!(id: params[:id])
    end
  
  end