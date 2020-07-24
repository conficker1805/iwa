wrapper(json) do
  json.(@user, :id, :name, :email, :role, :token)
end
