json.array!(@posts) do |post|
  json.extract! post, :id, :subject, :content
  json.url post_url(post, format: :json)
end
