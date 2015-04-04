json.array!(@pitches) do |pitch|
  json.extract! pitch, :id, :name, :type, :category, :text
  json.url pitch_url(pitch, format: :json)
end
