json.array!(@tickets) do |ticket|
  json.extract! ticket, :id, :date, :work_order, :job_code, :quantity, :user_id
  json.url ticket_url(ticket, format: :json)
end
