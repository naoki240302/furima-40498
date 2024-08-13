class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :move_to_index, only: [:edit, :update, :destroy]
  before_action :find_item, only: [:show, :edit, :update, :destroy]
  before_action :sold_out, only: [:edit]

  def index
    @items = Item.all.order('created_at DESC')
    @order = Order.all
  end

  def show
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to '/'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to '/'
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :explanation, :price, :image, :category_id, :condition_id, :charge_load_id,
                                 :shipping_time_id, :area_id).merge(user_id: current_user.id)
  end

  def move_to_index
    @item = Item.find(params[:id])
    @user = @item.user
    return unless @user != current_user

    redirect_to action: :index
  end

  def find_item
    @item = Item.find(params[:id])
  end

  def sold_out
    @item = Item.find(params[:id])
    return unless @item.sold_out?

    redirect_to action: :index
  end
end
