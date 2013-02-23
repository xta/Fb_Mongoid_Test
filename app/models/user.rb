class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :provider, type: String
  field :uid, type: String
  field :token, type: String
  field :expires_at, type: Integer

  field :first_name, type: String
  field :last_name, type: String
  field :nickname, type: String
  field :email, type: String
  field :image, type: String

  embeds_many :friends

  def self.from_omniauth(auth)
    where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      
      user.provider   = auth.provider
      user.token      = auth.credentials.token
      user.uid        = auth.uid
      user.nickname   = auth.info.nickname
      user.email      = auth.info.email
      user.first_name = auth.info.first_name
      user.last_name  = auth.info.last_name
      user.image      = auth.info.image
      user.expires_at = auth.credentials.expires_at

      create_users_friends(user)

    end
  end

  def self.create_users_friends(user)
    client        = FacebookWrapper.new(user)
    users_friends = client.friends

    users_friends.each do |friend|
      begin
        new_friend      = user.friends.build
        new_friend.name = friend["name"]
        new_friend.uid  = friend["id"]
        new_friend.save
      rescue Exception => e
        logger.debug e
      end
    end

  end

end