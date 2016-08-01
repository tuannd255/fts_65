class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :rememberable, :validatable,
    :omniauthable

  has_many :exams, dependent: :destroy
  has_many :suggest_questions, dependent: :destroy

  class << self
    def from_omniauth auth
      find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name
      end
    end

    def new_with_session params, session
      super.tap do |user|
        if data = session["devise.facebook_data"] &&
          session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end
  end
end
