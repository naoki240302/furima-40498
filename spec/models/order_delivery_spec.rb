require 'rails_helper'

RSpec.describe OrderDelivery, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_delivery = FactoryBot.build(:order_delivery, user_id: user.id, item_id: item.id)
  end

  describe '商品購入機能' do
    context '商品が購入できる時' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@order_delivery).to be_valid
      end
      it '建物名(building)が空でも保存できる' do
        @order_delivery.building = ''
        expect(@order_delivery).to be_valid
      end
    end

    context '商品が購入できない時' do
      it '郵便番号(post_number)が空だと保存できない' do
        @order_delivery.post_number = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Post number can't be blank")
      end
      it '郵便番号(post_number)が「3桁ハイフン4桁」以外だと保存できない' do
        @order_delivery.post_number = '1234567'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Post number is invalid. Include hyphen(-)')
      end
      it '都道府県(area_id)が空だと保存できない' do
        @order_delivery.area_id = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Area can't be blank")
      end
      it '市区町村(address)が空だと保存できない' do
        @order_delivery.address = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Address can't be blank")
      end
      it '番地(street)が空だと保存できない' do
        @order_delivery.street = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Street can't be blank")
      end
      it '電話番号(phone_number)が空だと保存できない' do
        @order_delivery.phone_number = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号(phone_number)9桁以下だと保存できない' do
        @order_delivery.phone_number = '123456789'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Phone number is invalid. Input only 10 to 11 half-width numbers.')
      end
      it '電話番号(phone_number)12桁以上だと保存できない' do
        @order_delivery.phone_number = '123456789012'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Phone number is invalid. Input only 10 to 11 half-width numbers.')
      end
      it '電話番号(phone_number)半角数値以外だと保存できない' do
        @order_delivery.phone_number = 'aaaaaaaaaaa'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Phone number is invalid. Input only 10 to 11 half-width numbers.')
      end
      it 'ユーザー(user_id)と紐ついていないと保存できない' do
        @order_delivery.user_id = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("User can't be blank")
      end
      it '商品(item_id)と紐ついていないと保存できない' do
        @order_delivery.item_id = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
