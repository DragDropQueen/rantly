class Search
  attr_reader :search_text

  def initialize(text = '')
    @search_text = text
  end

  def get_rants
    user_based = User.search search_text
    rant_based = Rant.search search_text

    Rant.where(user_id: user_based.records.records) + rant_based.records.records
  end
end