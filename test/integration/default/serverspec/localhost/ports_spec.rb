# Encoding: UTF-8

require 'spec_helper'
require 'json'
require 'net/http'

describe 'Longshoreman-related ports' do
  it 'is listening on port 80' do
    expect(port(80)).to be_listening
  end

  it 'is returning valid JSON from the Docker API over port 80' do
    uri = URI('http://localhost/containers/json')
    expect(JSON.parse(Net::HTTP.get(uri)).class).to eq(Array)
  end
end
