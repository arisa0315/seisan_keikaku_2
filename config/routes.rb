Rails.application.routes.draw do
  # 生産計画のルーティング
  resources :production_plans

  # シフトのルーティング
  resources :shifts

  # 登録情報のルーティング
  resources :registrations

  # ルートページを生産計画のインデックスページに設定
  root to: 'production_plans#index'
end
