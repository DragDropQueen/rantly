class MarkdownParser
  def initialize(text)
    @text = ActionView::Base.full_sanitizer.sanitize(text)
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {})
  end

  def render_html
    @markdown.render(@text).html_safe
  end
end