json.array!(@front_navs) do |front_nav|
  json.extract! front_nav, :id, :text, :user_id, :url, :icon, :shown, :code, :father_id, :weight, :level
  json.url front_nav_url(front_nav, format: :json)
end
