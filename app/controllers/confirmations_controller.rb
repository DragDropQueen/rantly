class ConfirmationsController < ApplicationController
  def show
    @confirmation = Confirmation.find_by(token: params[:id])

    if @confirmation
      @confirmation.set_confirmed_to_true
      redirect_to new_session_path, notice: 'Thank you for confirming your email! You may now log in.'
    else
      redirect_to root_path, notice: 'That is not a valid confirmation url!'
    end
  end

end