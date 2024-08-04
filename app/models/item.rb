class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one_attached :image

  validates :item_name, presence: true
  validates :explanation, presence: true
  validates :price, presence: true, numericality: { in: 300..9_999_999 }, format: { with: /\A[0-9]+\z/ }

  validates :category_id, presence: true, numericality: { other_than: 1 }, inclusion: { in: Category.pluck(:id) }
  validates :condition_id, presence: true, numericality: { other_than: 1 }, inclusion: { in: Condition.pluck(:id) }
  validates :charge_load_id, presence: true, numericality: { other_than: 1 }, inclusion: { in: ChargeLoad.pluck(:id) }
  validates :shipping_time_id, presence: true, numericality: { other_than: 1 }, inclusion: { in: ShippingTime.pluck(:id) }
  validates :area_id, presence: true, numericality: { other_than: 1 }, inclusion: { in: Area.pluck(:id) }

  validates :image, presence: true, blob: { content_type: :image }
end
