class Search
  attr_reader :search_text

  def initialize(text = '')
    @search_text = text.gsub('_', ' ').gsub('tagged-', '#')
  end

  def get_search_results
    if search_text.include?('#')
      get_hashtag_results
    else
      get_normal_results
    end
  end

  def get_hashtag_results
    Rant.where("title ILIKE '%#{search_text}%' OR rant ILIKE '%#{search_text}%'")
  end

  def get_normal_results
    user_based = User.search search_text
    rant_based = Rant.search search_text

    Rant.where(user: user_based.records.records) + rant_based.records.records
  end
end