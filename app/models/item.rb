class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category
  belongs_to :condition
  belongs_to :charge_load
  belongs_to :shipping_time
  belongs_to :area
  has_one_attached :image

  validates :item_name, presence: true
  validates :explanation, presence: true
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  validates :category_id, presence: true, numericality: { other_than: 1 }, inclusion: { in: Category.pluck(:id) }
  validates :condition_id, presence: true, numericality: { other_than: 1 }, inclusion: { in: Condition.pluck(:id) }
  validates :charge_load_id, presence: true, numericality: { other_than: 1 }, inclusion: { in: ChargeLoad.pluck(:id) }
  validates :shipping_time_id, presence: true, numericality: { other_than: 1 }, inclusion: { in: ShippingTime.pluck(:id) }
  validates :area_id, presence: true, numericality: { other_than: 1 }, inclusion: { in: Area.pluck(:id) }

  validates :image, presence: true, blob: { content_type: :image }
end
