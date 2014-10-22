module RantsHelper
  def get_latest_rants
    Rant.where("user_id != #{@user.id}").reverse[0..1]
  end

  def get_user_favorited_rants(user)
    Rant.where(user_id: user.id).sort_by {|rant|
      rant.favorites.count
    }.reverse
  end

  def get_mentioned_rants
    string = '@' + @user.username

    response = Rant.search query: { match: { rant: string } }

    response.records.records
  end

  def to_markdown(text)
    text = sanitize(text)

    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)

    markdown.render(text).html_safe
  end

  def link_hashtags

  end
end
