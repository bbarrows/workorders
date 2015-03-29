json.array!(@entries) do |entry|
  json.extract! entry, :id, :start, :end, :ticket_id
  json.url entry_url(entry, format: :json)
end
