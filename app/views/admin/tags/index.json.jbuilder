json.array!(@admin_tags) do |admin_tag|
  json.extract! admin_tag, :id, :name, :code
  json.url admin_tag_url(admin_tag, format: :json)
end
