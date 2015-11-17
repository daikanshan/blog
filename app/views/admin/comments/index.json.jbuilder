json.array!(@admin_comments) do |admin_comment|
  json.extract! admin_comment, :id, :from, :to, :content
  json.url admin_comment_url(admin_comment, format: :json)
end
