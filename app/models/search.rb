class Search
  attr_reader :search_text

  def initialize(text = '')
    @search_text = text.gsub('_', ' ')
  end

  def get_search_results
    user_based = User.search query: { match: {_all: search_text }}
    rant_based = Rant.search query: { match: {_all: search_text }}

    Rant.where(user_id: user_based.records.records) + rant_based.records.records
  end
end