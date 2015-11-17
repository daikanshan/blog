json.array!(@admin_messages) do |admin_message|
  json.extract! admin_message, :id, :title, :content, :abstract, :author, :tag, :category, :user_id
  json.url admin_message_url(admin_message, format: :json)
end
