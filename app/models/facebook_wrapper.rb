class FacebookWrapper

  attr_accessor :client

  def initialize(user)
    @client = Koala::Facebook::API.new(user.token)
  end

  def friends
    @client.get_connections("me", "friends")
  end

end