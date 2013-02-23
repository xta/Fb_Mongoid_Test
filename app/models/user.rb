class User
  include Mongoid::Document
  field :provider, type: String
  field :uid, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :token, type: String
end
