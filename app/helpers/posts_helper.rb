module PostsHelper
  def format_body(body)
    pipeline = HTML::Pipeline.new [
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::SyntaxHighlightFilter,
      HTML::Pipeline::AutolinkFilter
    ]
    pipeline.call(body)[:output].html_safe
  end
end
