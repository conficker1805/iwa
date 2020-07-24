wrapper(json) do
  json.set! :tests do
    json.array! @tests do |test|
      json.(test, :id, :name, :description)
    end
  end
end


