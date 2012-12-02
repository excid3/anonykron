module PostsHelper
  def post_body(post)
    pipeline = HTML::Pipeline.new [
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::SyntaxHighlightFilter,
      HTML::Pipeline::AutolinkFilter
    ]
    pipeline.call(post.body)[:output].html_safe
  end
end
