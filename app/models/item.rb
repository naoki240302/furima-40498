class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one_attached :image

  validates :item_name, presence: true
  validates :explanation, presence: true
  validates :price, presence: true

  validates :category_id, presence: true, numericality: { other_than: 1 }
  validates :condition_id, presence: true, numericality: { other_than: 1 }
  validates :charge_load_id, presence: true, numericality: { other_than: 1 }
  validates :shipping_time_id, presence: true, numericality: { other_than: 1 }
  validates :area_id, presence: true, numericality: { other_than: 1 }
end
