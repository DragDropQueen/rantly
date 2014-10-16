class SearchController < ApplicationController
  before_filter :set_sidebar, :require_authentication!

  def index
    @search = Search.new
  end

  def create
    redirect_to '/search/' + params[:search]
  end

  def show
    @search = Search.new(params[:id])
  end
end