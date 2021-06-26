# frozen_string_literal: true

CONFIG = YAML.safe_load(File.open('config/initializers/config.yml').read)

CONTENTFUL_ACCESS_TOKEN = ENV['CONTENTFUL_ACCESS_TOKEN']
CONTENTFUL_SPACE_ID = ENV['CONTENTFUL_SPACE_ID']
CONTENTFUL_ENVIRONMENT_ID = ENV['CONTENTFUL_ENVIRONMENT_ID'] || CONFIG['contentful_environment_id']

RECIPE_CONTENT_TYPE = 'recipe'

DEFAULT_SKIP = 0
DEFAULT_LIMIT = 100

ERROR_MESSAGES = {
  400 => 'BadRequest: Malformed request syntax',
  416 => 'RangeError: You may have specified invalid range for parameters',
  404 => 'NotFound: Specified resource not found',
  500 => 'Internal Server Error'
}.freeze
