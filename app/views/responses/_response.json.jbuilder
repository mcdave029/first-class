json.extract! response, :id, :reply, :keyword, :created_at, :updated_at
json.url response_url(response, format: :json)
