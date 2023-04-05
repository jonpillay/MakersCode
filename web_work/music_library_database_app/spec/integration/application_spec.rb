require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }


  context "POST to /albums" do
    it "returns 200 OK with albums listed" do
      # Send a GET request to /
      # and returns a response object we can test.
      response = post('/albums', title: 'Voyage', release_year: '2022', artist_id: '2')
      
      # Assert the response status code and body.
      expect(response.status).to eq(200)
      expect(get('/albums').body).to include "Voyage"
    end
  end

  context "GET /albums" do
    it "returns 200 OK with album added" do
      # Send a GET request to /
      # and returns a response object we can test.
      #length_check = get('/albums')
      response = get('/albums')
      
      # Assert the response status code and body.
      expect(response.status).to eq(200)
      expect(response.body).to include "I Put a Spell on You"
    end
  end

  context 'POST to /artist' do
    it "returns 200 with artists listed" do
      response = post('/artists', name: 'Wild nothing', genre: 'Indie')

      expect(response.status).to eq (200)
      expect(get('/artists').body).to include "Wild nothing"
    end
  end

  context 'GET to /artist' do
    it 'returns 200 with artists listed' do
      response = get('/artists')
      expect(response.status).to eq(200)
      expect(response.body).to include "Pixies"
    end
  end

end
