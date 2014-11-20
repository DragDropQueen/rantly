class RantsController < ApplicationController
  before_filter :require_authentication!, :set_sidebar

  def create
    @rant = Rant.new(rant_params)

    if @rant.save
      publish_keen_stats
      RantMailer.send_mail_to_followers(@rant, @user)
      render json: @rant
    else
      raise
    end
  end

  def update
    @rant = Rant.find(params[:id])

    @rant.update!({spam: true})

    redirect_to dashboard_path, notice: "#{@rant.title} has been marked as spam."
  end

  def destroy
    @rant = Rant.find(params[:id])

    if @rant.user_id == @user.id
      @rant.destroy
      flash[:notice] = "#{@rant.title} has been deleted!"
    else
      flash[:notice] = "Oops! Couldn't delete that rant!"
    end

    redirect_to dashboard_path
  end

  def show
    @display_rant = Rant.find(params[:id])
  end

  private

  def rant_params
    params.require(:rant).permit(:title, :rant).merge({user_id: @user.id})
  end

  def publish_keen_stats
    Keen.publish(:rant, {:email => @user.email, rant: @rant.title}) if Rails.env == 'production'
  end

  def index
    params[:count]
  end
end
