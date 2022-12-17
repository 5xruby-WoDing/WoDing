class Backstage::RestaurantsController < Backstage::ManagersController
  before_action :find_restaurant, only: [:show, :edit, :update, :destroy]

  def new
    @restaurant = current_manager.restaurants.new
  end

  def create
    @restaurant = current_manager.restaurants.new(params_restaurant)
    if @restaurant.save
      redirect_to backstage_root_path(current_manager.id), notice: '新增成功'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @restaurant.update(params_restaurant)
      redirect_to backstage_manager_path(current_manager.id), notice: '更新成功'
    else
      render :edit
    end
  end

  def show
    @seats = @restaurant.seats
  end

  def destroy
    @restaurant.destroy
    redirect_to backstage_root_path(current_manager.id), notice: '已刪除'
  end

  private
  def params_restaurant
    params.require(:restaurant).permit(:title, :tel, :address, :branch, :start_time, :end_time, :period_of_reservation, :tag_list, :dining_time)
  end

  def find_restaurant
    @restaurant = current_manager.restaurants.find(params[:id])
  end

end