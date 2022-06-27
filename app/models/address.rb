class Address < ActiveRecord::Base
  belongs_to  :user

  def full_address
    "#{street}, #{ward}, #{district}, #{province}"
  end
end
