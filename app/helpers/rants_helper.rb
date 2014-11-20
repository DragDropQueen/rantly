module RantsHelper
  def get_latest_rants
    Rant.where("user_id != #{@user.id}").reverse[0..1]
  end

  def get_user_favorited_rants(user)
    Rant.where(user_id: user.id).sort_by { |rant|
      rant.favorites.count
    }.reverse
  end

  def get_mentioned_rants
    string = @user.email

    response = Rant.search string

    response.records.records
  end

  def render_rant(text)
    text = sanitize(text)

    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)

    text = markdown.render(text)

    tags = text.scan(/#\w+/)


    tags.each { |tag|
      unless tag == '#39'
        url = tag.gsub('#', '')
        text.gsub!(tag, "<a href='/search/tagged-#{url}'>#{tag}</a>")
      end
    }

    text.html_safe
  end
end
