json.extract! user_admin, :id, :name, :username, :password, :created_at, :updated_at
json.url user_admin_url(user_admin, format: :json)
