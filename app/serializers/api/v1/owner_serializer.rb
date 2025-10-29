class Api::V1::OwnerSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :created_at, :updated_at, :user_name

  def user_name
    object.user.entire_name if object.user
  end
end
