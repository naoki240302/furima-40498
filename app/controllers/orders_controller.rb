class OrdersController < ApplicationController
  def index
    @order_delivery = OrderDelivery.new
    @item = Item.find(params[:item_id])
  end

  def create
    @order_delivery = OrderDelivery.new(order_params)
    if @order_delivery.valid?
      @order_delivery.save
      redirect_to '/'
    else
      @item = Item.find(params[:item_id])
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_delivery).permit(:post_number, :area_id, :address, :street, :building,
                                           :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
