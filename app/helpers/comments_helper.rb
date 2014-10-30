module CommentsHelper
  def comment
    @comment ||= Comment.new
  end
end