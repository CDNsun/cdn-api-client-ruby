require 'securerandom'

RSpec.describe CDNsunCdnApiClient do
  describe "initialization" do
    context "when the username is invalid" do
      it "throws an exception" do
        expect do
          CDNsunCdnApiClient.new(username: nil, password: SecureRandom.hex)
        end.to raise_exception(CDNsunCdnApiClient::InvalidParameters)
      end
    end

    context "when the username is valid" do
      context "when the password is invalid" do
        it "throws an exception" do
          expect do
            CDNsunCdnApiClient.new(username: SecureRandom.hex, password: nil)
          end.to raise_exception(CDNsunCdnApiClient::InvalidParameters)
        end
      end

      context "when the password is valid" do
        it "inits the client" do
          api_client = CDNsunCdnApiClient.new(username: SecureRandom.hex, password: SecureRandom.hex)

          expect(api_client).to be_kind_of(CDNsunCdnApiClient)
        end
      end
    end
  end

  let(:username) { SecureRandom.hex }
  let(:password) { SecureRandom.hex }
  let(:api_client) { CDNsunCdnApiClient.new(username: username, password: password) }
  let(:options) { {data: {value: SecureRandom.hex}, url: 'cdns'} }

  before do
    allow(api_client).to receive(:request)
  end

  describe "#get" do
    it "performs the request" do
      expect(api_client).to receive(:request).with(:get, options)

      api_client.get(options)
    end
  end

  describe "#post" do
    it "performs the request" do
      expect(api_client).to receive(:request).with(:post, options)

      api_client.post(options)
    end
  end

  describe "#put" do
    it "performs the request" do
      expect(api_client).to receive(:request).with(:put, options)

      api_client.put(options)
    end
  end

  describe "#delete" do
    it "performs the request" do
      expect(api_client).to receive(:request).with(:delete, options)

      api_client.delete(options)
    end
  end

  describe "#request" do
    before do
      allow(api_client).to receive(:request).and_call_original
    end

    context "when the supplied options hash is empty" do
      it "throws an exception" do
        expect do
          api_client.request(:get, nil)
        end.to raise_exception(CDNsunCdnApiClient::InvalidParameters)
      end
    end

    context "when the supplied options hash doesn't include url" do
      it "throws an exception" do
        expect do
          api_client.request(:get, { url: nil })
        end.to raise_exception(CDNsunCdnApiClient::InvalidParameters)
      end
    end

    context "when the method is invalid" do
      it "throws an exception" do
        expect do
          api_client.request(nil, { url: "cdns" })
        end.to raise_exception(CDNsunCdnApiClient::InvalidParameters)
      end
    end

    context "when the supplied options hash is valid" do
      let(:response) { double(:response, parsed_response: {}) }

      it "performs the request" do
        expect(CDNsunCdnApiClient).to receive(:get).with(
          "/#{options[:url]}",
          query: options[:data],
          basic_auth: { username: username, password: password },
          timeout: CDNsunCdnApiClient::REQUEST_TIMEOUT,
          headers: { 'Content-Type' => 'application/json' }
        ).and_return(response)

        api_client.request(:get, options)
      end

      it "returns the decoded body" do
        allow(CDNsunCdnApiClient).to receive(:get).and_return(response)

        parsed_response = api_client.request(:get, options)

        expect(parsed_response).to be_kind_of(Hash)
      end
    end
  end
end
