class User < ActiveRecord::Base
  has_many :todos, dependent: :destroy
  has_many :identitys, dependent: :destroy

  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :confirmable 
         
    validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          name: auth.extra.raw_info.name,
          #username: auth.info.nickname || auth.uid,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        user.skip_confirmation!
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end
  

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
      user = User.where(:provider => auth.provider, :uid => auth.uid).first
      if user
        return user
      else
        registered_user = User.where(:email => auth.uid + "@twitter.com").first
        if registered_user
          return registered_user
        else

          user = User.create(full_name:auth.extra.raw_info.name,
                              provider:auth.provider,
                              uid:auth.uid,
                              email:auth.uid+"@twitter.com",
                              oauth_token:auth.credentials.token,
                              oauth_secret:auth.credentials.secret,
                              password:Devise.friendly_token[0,20],
                            )
        end

      end
    end

    def tweet(tweet)
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['TWITTER_ID']
        config.consumer_secret     = ENV['TWITTER_PASSWORD']
        config.access_token        =  "1730815525-N4KzSQcOM0n6IiJWdQCrSGjVo20ORDiRWPBGhkO"
        config.access_token_secret = "Wmtk0HJ5GIVSHdGo2mclW1mndXv2VKTezkgPHbvrkh2EC"
      end

      client.update(tweet)
    end
end