class Admin::RantsController < Admin::AdminController
  def index
    get_filtered_rants

    @rants = @rants.where(spam: false).reverse
  end

  def update
    @rant = Rant.unscoped.find(params[:id])

    @rant.update(spam: false)

    redirect_to admin_spam_path, notice: "Rant #{@rant.title} has been marked as not spam."
  end

  def destroy
    @rant = Rant.unscoped.find(params[:id])

    @rant.destroy

    redirect_to admin_spam_path, notice: "Rant #{@rant.title} has been deleted."
  end

  def spam
    get_filtered_rants

    @rants = @rants.where(spam: true).reverse
  end

  private

  def get_filtered_rants
    @rants = Rant.unscoped.all

    filter_by_end_date

    filter_by_start_date
  end

  def filter_by_start_date
    if params[:start_date] && params[:start_date] != ''
      date = Date.parse(params[:start_date])

      @rants = @rants.where("created_at > '#{date}'")
    end
  end

  def filter_by_end_date
    if params[:end_date] && params[:end_date] != ''
      date = Date.parse(params[:end_date])

      @rants = @rants.where("created_at < '#{date}'")
    end
  end
end