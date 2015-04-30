json.array!(@media) do |medium|
  json.extract! medium, :id, :context, :user_id, :token, :week_session_id, :due_date
  json.url medium_url(medium, format: :json)
end
