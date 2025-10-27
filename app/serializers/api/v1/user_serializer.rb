class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :last_name, :created_at, :updated_at
end
