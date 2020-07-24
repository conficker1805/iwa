module JsonLayoutHelper
  def wrapper(json = {})
    json.set! :success, true
    json.data do
      yield if block_given?
    end
  end
end
