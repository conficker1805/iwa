wrapper(json) do
  json.(@test, :id, :name, :description)
  json.set! :questions do
    json.array! @test.questions do |question|
      json.(question, :id, :label)
      json.set! :options do
        json.array! question.options do |option|
          json.(option, :id, :label)
        end
      end
    end
  end
end
