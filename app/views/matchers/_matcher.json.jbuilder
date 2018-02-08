json.extract! matcher, :id, :uri_pattern, :url_replacement_pattern, :name, :priority, :created_at, :updated_at
json.url matcher_url(matcher, format: :json)
