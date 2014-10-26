module Confirmable
  extend ActiveSupport::Concern

  included do
    def create_confirmation_and_send_email
      confirmation = Confirmation.create!({
                             user_id: id,
                             token: generate_token
                           })

      UserMailer.confirmation_email(self, confirmation.token).deliver
    end

    def generate_token
      SecureRandom.hex
    end
  end
end