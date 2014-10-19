class RantsController < ApplicationController
  before_filter :require_authentication!, :set_sidebar

  def create
    @rant = Rant.new(rant_params)
    if @rant.save
      redirect_to root_path, notice: 'Your rant has been posted!'
    else
      render :'dashboards/show'
    end
  end

  def destroy
    @rant = Rant.find(params[:id])

    if @rant.user_id == @user.id
      @rant.destroy
      flash[:notice] = 'rant deleted!'
    else
      flash[:notice] = 'you can only delete your own rants!'
    end

    redirect_to '/dashboard'
  end

  def show
    @comment = Comment.new
    @display_rant = Rant.find(params[:id])
  end

  private

  def rant_params
    params.require(:rant).permit(:title, :rant).merge({user_id: @user.id})
  end

  def index
    params[:count]
  end
end
