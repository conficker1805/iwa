json.set! :success, false
json.set! :message, @message

if Rails.env.development?
  json.set! :details, @details
end
