class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :last_name, :created_at, :updated_at, :owner_id

  def owner_id
    object.owner.id if object.owner
  end
end
