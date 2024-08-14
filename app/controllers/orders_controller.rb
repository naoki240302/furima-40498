class OrdersController < ApplicationController
  before_action :find_item, only: [:index, :create]
  before_action :authenticate_user!, only: [:index]
  before_action :move_to_index, only: [:index]
  before_action :sold_out, only: [:index]
  before_action :gon_public_key, only: [:index, :create]
  def index
    @order_delivery = OrderDelivery.new
  end

  def create
    @order_delivery = OrderDelivery.new(order_params)
    if @order_delivery.valid?
      pay_item
      @order_delivery.save
      redirect_to '/'
    else
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
    @user = @item.user
    return unless @user == current_user

    redirect_to '/'
  end

  def sold_out
    return unless @item.sold_out?

    redirect_to '/'
  end

  def find_item
    @item = Item.find(params[:item_id])
  end

  def gon_public_key
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
  end
end
