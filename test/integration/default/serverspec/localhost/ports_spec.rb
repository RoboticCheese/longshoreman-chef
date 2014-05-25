# Encoding: UTF-8

require 'spec_helper'
require 'json'
require 'net/http'

describe 'Longshoreman-related ports' do
  it 'is listening on port 443' do
    expect(port(443)).to be_listening
  end

  it 'is returning valid JSON from the Docker API over port 443' do
    uri = URI('https://localhost/containers/json')
    expect(JSON.parse(Net::HTTP.get(uri)).class).to eq(Array)
  end
end
