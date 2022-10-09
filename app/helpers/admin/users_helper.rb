module Admin
  module UsersHelper
    def user_info_fields(user)
      user.attributes.slice('email', 'first_name', 'last_name', 'phone', 'birth',
                            'gender', 'is_partner', 'is_admin', 'created_at').compact
    end

    def user_paper_infos(paper)
      paper.slice('card_number', 'card_front_url', 'card_back_url',
                  'driver_number', 'driver_front_url').compact
    end
  end
end
