# Encoding: UTF-8

require 'spec_helper'
require 'json'
require 'net/http'

describe 'Longshoreman-related ports' do
  it 'is listening on port 443 for Docker' do
    expect(port(443)).to be_listening
  end

  it 'is listening on port 8123 for Polipo' do
    expect(port(8123)).to be_listening
  end

  it 'is returning valid JSON from the Docker API over port 443' do
    uri = URI('https://localhost/containers/json')
    opt = {
      use_ssl: true,
      # TODO: Shouldn't VERIFY_PEER pass too?
      verify_mode: OpenSSL::SSL::VERIFY_NONE,
      ca_file: '/opt/longshoreman/tls/ca.pem',
      cert: OpenSSL::X509::Certificate.new(
        File.open('/opt/longshoreman/tls/cert.pem').read
      ),
      key: OpenSSL::PKey::RSA.new(
        File.open('/opt/longshoreman/tls/key.pem').read
      )
    }
    response = Net::HTTP.start(uri.host, uri.port, opt) do |http|
      http.request(Net::HTTP::Get.new(uri.path))
    end
    expect(JSON.parse(response.body).class).to eq(Array)
  end
end
