# frozen_string_literal: true

module ApplicationHelper
  def markdown(text)
    options = %i[hard_wrap link_attributes autolink safe_links_only quote
                 no_intra_emphasis]
    Markdown.new(text, *options).to_html.html_safe
  end

  def error_handler(err)
    case err.class.to_s
    when /RangeError/
      render_error(416)
    when /ArgumentError/
      render_error(404)
    when /BadRequest/
      render_error(400)
    else
      render_error(500)
    end
  end

  def render_error(status)
    respond_to do |format|
      format.html { render status: status, file: "public/#{status}.html", layout: false }
      format.json do
        render json: { status: status, error: true, message: ERROR_MESSAGES[status] || 'Error' }
      end
    end
  end
end
