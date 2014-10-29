class Admin::RantsController < Admin::AdminController
  def index
    @rants = Rant.all.reverse
  end

  def filter
    @rants = Rant.all

    filter_by_end_date

    filter_by_start_date

    render :index
  end

  private

  def filter_by_start_date
    if params[:start_date] != ''
      date = Date.parse(params[:start_date])

      @rants = @rants.where("created_at > '#{date}'")
    end
  end

  def filter_by_end_date
    if params[:end_date] != ''
      date = Date.parse(params[:end_date])

      @rants = @rants.where("created_at < '#{date}'")
    end
  end
end