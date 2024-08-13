class OrdersController < ApplicationController
  before_action :move_to_index, only: [:index]
  before_action :sold_out, only: [:index]
  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_delivery = OrderDelivery.new
    @item = Item.find(params[:item_id])
  end

  def create
    @order_delivery = OrderDelivery.new(order_params)
    @item = Item.find(params[:item_id])
    if @order_delivery.valid?
      pay_item
      @order_delivery.save
      redirect_to '/'
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_delivery).permit(:post_number, :area_id, :address, :street, :building,
                                           :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: order_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end

  def move_to_index
    @item = Item.find(params[:item_id])
    @user = @item.user
    return unless @user == current_user || current_user.nil?

    redirect_to '/'
  end

  def sold_out
    @item = Item.find(params[:item_id])
    return unless @item.sold_out?

    redirect_to '/'
  end
end
