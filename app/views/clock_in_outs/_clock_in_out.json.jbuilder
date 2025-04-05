json.extract! clock_in_out, :id, :target_date, :clock_in, :clock_out, :duration, :user_id, :created_at, :updated_at
json.url clock_in_out_url(clock_in_out, format: :json)
