class SearchController < ApplicationController
  before_filter :set_sidebar, :require_authentication!

  def index
    @search = Search.new
  end

  def create
    search = params[:search].gsub(' ', '_')

    redirect_to '/search/' + search
  end

  def show
    @search = Search.new(params[:id])
  end
end