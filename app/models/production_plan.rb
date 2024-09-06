class ProductionPlan < ApplicationRecord
  belongs_to :shift
  belongs_to :change_shift, class_name: 'Shift', optional: true
  belongs_to :registration # Registrationテーブルとの関連を追加

  before_save :calculate_operation_rate
  before_save :calculate_end_time

  private

  # 可動率の計算
  def calculate_operation_rate
    if registration && actual && registration.ct
      production_time = (Time.now - self.start_time) / 3600.0 # 時間に変換
      self.operation_rate = (self.actual * registration.ct) / production_time
    end
  end

  # 生産終了予定時刻を計算
  def calculate_end_time
    # Registrationテーブルからctとyieldを取得
    if start_time && production_count && registration&.ct && registration&.yield
      ct = registration.ct
      yield_rate = registration.yield

      # 生産時間を計算 (ct * yield)
      effective_production_time = (production_count.to_f / (ct.to_f * (yield_rate.to_f / 100)))

      # 開始時刻に生産時間を加算
      calculated_end_time = start_time + effective_production_time * 60 # 分へ変換

      # 休憩時間を考慮
      breaks = [
        { start: Time.parse('10:00'), end: Time.parse('10:10') },
        { start: Time.parse('12:00'), end: Time.parse('13:00') },
        { start: Time.parse('15:00'), end: Time.parse('15:10') }
      ]

      breaks.each do |break_time|
        if calculated_end_time > break_time[:start] && calculated_end_time < break_time[:end]
          # 休憩時間内ならその分を加算
          calculated_end_time += (break_time[:end] - break_time[:start])
        elsif start_time < break_time[:start] && calculated_end_time > break_time[:start]
          # 開始時刻と終了時刻が休憩時間をまたぐ場合
          calculated_end_time += (break_time[:end] - break_time[:start])
        end
      end

      # 計算された終了時刻をモデルに保存
      self.end_time = calculated_end_time
    end
  end
end
