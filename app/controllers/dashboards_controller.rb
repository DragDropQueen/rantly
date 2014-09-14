class DashboardsController < ApplicationController
  before_filter :require_authentication!, :set_sidebar

  def show
  end
end