class User < ActiveRecord::Base
  # :timeoutable
  devise :database_authenticatable,
         :confirmable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :trackable,
         :lockable,
         :omniauthable,
         omniauth_providers: %i[facebook google_oauth2]
  mount_uploader :photo_url, PictureUploader
  before_save :downcase_email
  validate :avatar_size
  has_many :addresses, dependent: :destroy
  has_one :paper, dependent: :destroy
  has_many :vehicles, dependent: :destroy
  validates :email, presence: true
  validates :phone, presence: true
  validates :first_name, presence: true,
                         length: { minimum: 2 }
  validates :last_name, presence: true,
                        length: { minimum: 2 }

  accepts_nested_attributes_for :addresses, :paper

  def self.from_omniauth(auth)
    result = User.where(email: auth.info.email).first
    return result if result.present?

    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      # user.photo_url = auth.info.image
      user.skip_confirmation!
    end
  end

  def downcase_email
    self.email = email.downcase
  end

  def full_name
    "#{last_name} #{first_name}"
  end

  private

  def avatar_size
    return unless photo_url.size > 3.megabytes

    errors.add(:photo_url, I18n.t('image.min'))
  end
end
