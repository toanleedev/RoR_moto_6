# == Schema Information
#
# Table name: papers
#
#  id               :bigint           not null, primary key
#  user_id          :bigint           not null
#  card_number      :string
#  card_front_url   :text
#  card_back_url    :text
#  driver_number    :string
#  driver_front_url :text
#  verified_at      :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  status           :integer          default("open")
#
class Paper < ActiveRecord::Base
  belongs_to  :user
  mount_uploader :card_front_url, PaperUploader
  mount_uploader :card_back_url, PaperUploader
  mount_uploader :driver_front_url, PaperUploader

  enum status: {
    open: 0,
    confirmed: 1,
    rejected: 2
  }

  validates :card_number, presence: true,
                          format: { with: /\A(?=\d*$)(?:.{9}|.{12})\z/,
                                    message: I18n.t('.account.papers.validate.card_number') }
  validates :driver_number, presence: true,
                            format: { with: /\A\d{12}\z/,
                                      message: I18n.t('.account.papers.validate.driver_number') }
  validates :card_front_url, :card_back_url, :driver_front_url, presence: true, format: {
    with: %r{\.jpg|png}i,
    message: I18n.t('.account.papers.validate.url')
  }
end
