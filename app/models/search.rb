class Search
  attr_reader :search_text

  def initialize(text = '')
    @search_text = text
  end

  def get_rants_based_on_user
    response = User.search search_text

    Rant.where(user_id: response.records.records)
  end
end