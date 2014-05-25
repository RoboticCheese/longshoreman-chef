# Encoding: UTF-8

require 'spec_helper'

describe 'Longshoreman-related services' do
  %w(docker).each do |s|
    it "is running #{s.capitalize}" do
      expect(service(s)).to be_running
      expect(service(s)).to be_enabled
    end
  end
end
