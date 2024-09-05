# READNE
このアプリケーションは、製造現場における生産計画を管理するためのツールです。
生産数、実績、可動率、終了予定時刻などの管理が行え、シフトや体制の切り替え時間を自動計算します。
また、登録ページで生産体制やサイクルタイム（C.T）、出来高を新規登録することができます。

## Users テーブル
｜ Column ｜ Type ｜ Options ｜
｜--------------------｜-----------｜--------------------------------｜
｜ nickname ｜ string ｜ null: false ｜
｜ email ｜ string ｜ null: false, unique: true ｜
｜ encrypted_password ｜ string ｜ null: false ｜
｜ first_name ｜ string ｜ null: false ｜
｜ last_name ｜ string ｜ null: false ｜
｜ first_name_kana ｜ string ｜ null: false ｜
｜ last_name_kana ｜ string ｜ null: false ｜
｜ birthday ｜ date ｜ null: false ｜

Users
has_many
has_many

### Items テーブル
｜ Column ｜ Type ｜ Options ｜
｜-------------------｜------------｜--------------------------------｜
｜ name ｜ string ｜ null: false ｜
｜ description ｜ text ｜ null: false ｜
｜ category_id ｜ integer ｜ null: false ｜
｜ condition_id ｜ integer ｜ null: false ｜
｜ shipping_fee_id ｜ integer ｜ null: false ｜
｜ prefecture_id ｜ integer ｜ null: false ｜
｜ shipping_days_id ｜ integer ｜ null: false ｜
｜ price ｜ integer ｜ null: false ｜
｜ user ｜ references ｜ null: false, foreign_key: true ｜

Items
belongs_to
has_one

#### Orders テーブル
｜ Column ｜ Type ｜ Options ｜
｜---------｜------------｜--------------------------------｜
｜ item ｜ references ｜ null: false, foreign_key: true ｜
｜ user ｜ references ｜ null: false, foreign_key: true ｜

Orders
belongs_to
belongs_to
has_one

##### Addresses テーブル
｜ Column ｜ Type ｜ Options ｜
｜------------------｜------------｜--------------------------------｜
｜ order ｜ references ｜ null: false, foreign_key: true ｜
｜ postal_code ｜ string ｜ null: false ｜
｜ city ｜ string ｜ null: false ｜
｜ address ｜ string ｜ null: false ｜
｜ building ｜ string ｜ ｜
｜ phone_number ｜ string ｜ null: false ｜
｜ prefecture_id ｜ integer ｜ null: false ｜

Addresses
belongs_to