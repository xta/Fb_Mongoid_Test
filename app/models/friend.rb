class Friend
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :uid, type: String

  embedded_in :user

end
