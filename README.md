## usersテーブル
| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| nickname            | string     | null: false                    |
| email               | string     | null: false, unique: true      |
| encrypted_password  | string     | null: false                    |
| last_name           | string     | null: false                    |
| first_name          | string     | null: false                    |
| kana_last           | string     | null: false                    |
| kana_first          | string     | null: false                    |
| birthday            | date       | null; false                    |

### Association
- has_many :items
- has_many :orders

## itemsテーブル
| Column             | Type       | Options                        |
| --------------     | ---------- | ------------------------------ |
| item_name          | string     | null: false                    |
| explanation        | text       | null: false                    |
| price              | integer    | null; false                    |
| category_id        | integer    | null; false                    |
| condition_id       | integer    | null; false                    |
| charge_load_id     | integer    | null; false                    |
| shipping_time_id   | integer    | null; false                    |
| area_id            | integer    | null; false                    |
| user               | references | null; false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :category
- belongs_to :condition
- belongs_to :charge_load
- belongs_to :shipping_time
- belongs_to :area
- has_one :order

## categoryテーブル Activehash
| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| category       | string     |                                |

### Association
- has_many :items

## conditionテーブル Activehash
| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| condition      | string     |                                |

### Association
- has_many :items

## charge_loadテーブル Activehash
| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| charge_load    | string     |                                |

### Association
- has_many :items

## areaテーブル Activehash
| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| area           | string     |                                |

### Association
- has_many :items
- has_many :deliverys

## shipping_timeテーブル Activehash
| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| shipping_time  | string     |                                |

### Association
- has_many :items

## ordersテーブル
| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |
| item      | references | null; false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :delivery


## deliverysテーブル
| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| post_number   | string     | null; false                    |
| area_id       | integer    | null; false                    |
| address       | string     | null; false                    |
| street        | string     | null; false                    |
| building      | string     |                                |
| phone_number  | string     | null; false                    |
| order         | references | null; false, foreign_key: true |

### Association
- belongs_to :order
- belongs_to :area