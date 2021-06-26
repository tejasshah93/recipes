# frozen_string_literal: true

class ContentfulClient
  include Singleton

  def client
    @client ||= Contentful::Client.new(
      access_token: CONTENTFUL_ACCESS_TOKEN,
      space: CONTENTFUL_SPACE_ID,
      environment: CONTENTFUL_ENVIRONMENT_ID,
      dynamic_entries: :auto,
      raise_errors: true
    )
  end
end
