class CreateDeliveries < ActiveRecord::Migration[7.0]
  def change
    create_table :deliveries do |t|
      t.string        :post_number,    null:false
      t.integer       :area_id,        null:false
      t.string        :address,        null:false
      t.string        :street,         null:false
      t.string        :building
      t.string        :phone_number,   null:false
      t.references     :order,          null:false, foreign_key: true
      t.timestamps
    end
  end
end