class OrderDelivery
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_number, :area_id, :address, :street, :building, :phone_number

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :post_number, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :area_id, numericality: { other_than: 1 }
    validates :address
    validates :street
    validates :phone_number, format: { with: /\A\d+\z/, message: 'is invalid. Input only half-width numbers.' }
  end

  def save
    order = Order.create(user_id:, item_id:)
    Delivery.create(post_number:, area_id:, address:, street:, building:,
                    phone_number:, order_id: order.id)
  end
end
