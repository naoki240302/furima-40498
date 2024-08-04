require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品ができる時' do
    context '新規登録できる時' do
      it '正常に登録できる' do
        expect(@item).to be_valid
      end
    end

    context '新規登録できない時' do
      it 'item_nameが空では登録できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      it 'explanationが空では登録できない' do
        @item.explanation = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Explanation can't be blank")
      end
      it 'priceが空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceは300~9999999の範囲外では登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be in 300..9999999')
      end
      it 'priceは半角数値以外では登録できない' do
        @item.price = '１０'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'category_idが空では登録できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'category_idが指定以外の番号では登録できない' do
        @item.category_id = 12
        @item.valid?
        expect(@item.errors.full_messages).to include('Category is not included in the list')
      end
      it 'condition_idが空では登録できない' do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it 'condition_idが指定以外の番号では登録できない' do
        @item.condition_id = 8
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition is not included in the list')
      end
      it 'charge_load_idが空では登録できない' do
        @item.charge_load_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Charge load can't be blank")
      end
      it 'charge_load_idが指定以外の番号では登録できない' do
        @item.charge_load_id = 4
        @item.valid?
        expect(@item.errors.full_messages).to include('Charge load is not included in the list')
      end
      it 'shipping_time_idが空では登録できない' do
        @item.shipping_time_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping time can't be blank")
      end
      it 'shipping_time_idが指定以外の番号では登録できない' do
        @item.shipping_time_id = 5
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping time is not included in the list')
      end
      it 'area_idが空では登録できない' do
        @item.area_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Area can't be blank")
      end
      it 'area_idが指定以外の番号では登録できない' do
        @item.area_id = 49
        @item.valid?
        expect(@item.errors.full_messages).to include('Area is not included in the list')
      end
      it '画像が空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'ユーザーが紐ついていないと登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
