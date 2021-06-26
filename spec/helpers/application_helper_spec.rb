# frozen_string_literal: true

require 'spec_helper'

describe ApplicationHelper do
  describe '#markdown' do
    it 'converts markdown format to html' do
      expect(markdown('**a**')).to eq("<p><strong>a</strong></p>\n")
      expect(markdown('[Example](https://www.example.com)')).to eq("<p><a href=\"https://www.example.com\">Example</a></p>\n")
    end
  end
end
