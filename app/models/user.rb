# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  photo_url              :text
#  birth                  :datetime
#  phone                  :string
#  gender                 :integer
#  is_partner             :boolean          default(FALSE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  provider               :string
#  uid                    :string
#  is_admin               :boolean
#  status                 :integer          default("online")
#
class User < ActiveRecord::Base
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,
         :lockable, :omniauthable,
         authentication_keys: [:email],
         omniauth_providers: %i[facebook google_oauth2]
  mount_uploader :photo_url, PictureUploader
  before_save :downcase_email

  has_one :paper, dependent: :destroy
  has_one :address, dependent: :destroy
  has_one :partner_history, dependent: :destroy
  has_one :partner, dependent: :destroy
  has_many :vehicles, dependent: :destroy
  has_many :orders, class_name: 'Order', foreign_key: 'renter_id'
  has_many :order_manages, class_name: 'Order', foreign_key: 'owner_id'
  has_many :notifications, foreign_key: :receiver_id, dependent: :destroy
  has_many :ratings, through: :orders, foreign_key: 'renter_id', source: :renter_rating
  has_many :payment_histories, class_name: 'Payment', dependent: :destroy

  validate :avatar_size
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true,
                         length: { minimum: 2 }
  validates :last_name, presence: true,
                        length: { minimum: 2 }
  enum gender: {
    other: 0,
    male: 1,
    female: 2
  }

  enum status: {
    online: 0,
    offline: 1,
    blocked: 4
  }

  scope :admins, -> { where(is_admin: true) }

  accepts_nested_attributes_for :paper

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

  def partner?
    partner.present? && partner.confirmed?
  end

  def average_rating
    arr_points = ratings.pluck(:rating_point)
    return 0 if arr_points.empty?

    arr_points.reduce(:+).to_f / arr_points.size
  end

  def message_rooms
    User.joins('INNER JOIN messages ON messages.sender_id = users.id
      OR messages.receiver_id = users.id')
        .where('messages.receiver_id = :user_id OR messages.sender_id = :user_id', user_id: self.id)
        .where.not(id: self.id)
        .distinct
  end

  private

  def avatar_size
    return unless photo_url.size > 3.megabytes

    errors.add(:photo_url, I18n.t('image.min'))
  end
end
