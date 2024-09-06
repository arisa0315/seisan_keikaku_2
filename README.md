# READNE

## 概要

このアプリケーションは、製造現場における生産計画を管理するためのものです。  
生産数、実績、開始時刻などの情報を入力することで、可動率や終了予定時刻を自動的に計算します。  
生産体制の情報は、データベースに登録し、新規登録ページで追加することができます。

## 主な機能

1. **トップページ**
   - 生産数、実績、生産開始時刻の入力。
   - 自動計算された可動率と終了予定時刻の表示。
   - 生産体制のプルダウンメニューからの選択。
   - 「新規登録」ボタンによる新規登録ページへの遷移。

2. **新規登録ページ**
   - 登録名、C.T（サイクルタイム）、出来高を入力し、データベースに保存。
   - 登録した体制の一覧表示。

3. **自動計算**
   - **可動率** = `実績 * C.T / 生産時間`
   - **終了予定時刻** = `生産開始時刻 + (生産数 ÷ (C.T / 出来高)) + 休憩時間`
   - **切り替え予定時刻** = `(定時 − 8:00 − 休憩時間) × 生産開始C.T × 生産開始出来高 ÷ 60 + 残りの生産数 × 切り替え予定C.T × 切り替え予定出来高 ÷ 60`

## テーブル設計

### production_plans テーブル

| Column                   | Type       | Options                       |
|--------------------------|------------|-------------------------------|
| id                        | INT        | primary_key                   |
| production_count          | INT        | null: false                   |
| actual_performance        | INT        | null: false                   |
| start_time                | DATETIME   | null: false                   |
| operation_rate            | FLOAT      | null: true (自動計算)          |
| estimated_end_time        | DATETIME   | null: true (自動計算)          |
| current_production_system | VARCHAR    | null: false, foreign_key: true |
| planned_switch_system     | VARCHAR    | null: false, foreign_key: true |
| planned_switch_time       | DATETIME   | null: true (自動計算)          |

- `has_one :production_system`

### production_systems テーブル

| Column        | Type       | Options             |
|---------------|------------|---------------------|
| id            | INT        | primary_key         |
| name          | VARCHAR    | null: false         |
| cycle_time    | INT        | null: false         |
| output_rate   | FLOAT      | null: false         |

- `has_many :production_plans`
