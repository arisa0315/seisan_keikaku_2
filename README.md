# READNE

## ProductionPlans（生産計画）

|Column|Type|Options|
|------|----|-------|
|id|integer|PK, 自動生成|
|production_count|integer|null: false|
|actual|integer|null: false|
|operation_rate|float|null: false, 自動計算|
|start_time|datetime|null: false|
|end_time|datetime|自動計算|
|shift_id|integer|外部キー (Shifts), null: false|
|change_shift_id|integer|外部キー (Shifts)|

### Association
- belongs_to :shift
- belongs_to :change_shift, class_name: 'Shift'

## Shifts（シフト）

|Column|Type|Options|
|------|----|-------|
|id|integer|PK, 自動生成|
|name|string|null: false|

### Association
- has_many :production_plans

## Registrations（登録）

|Column|Type|Options|
|------|----|-------|
|id|integer|PK, 自動生成|
|name|string|null: false|
|ct|integer|null: false|
|yield|float|null: false|

### Association
- none
