require "spec_helper"

describe "API Docs - ", :type => :api do
  # Parses index.litcoffee and tests API from there
  # @ represents a shorthand for entities
  contents = File.open(Rails.root.join('index.litcoffee'), "rb").read

  # get the methods, separated by the star titles
  # TODO: currently uses capital Rs for Request Response, kind of weird
  methods = []
  match = contents.scan(/\*\*(.*)\*\*[^\*]*(GET|POST|PUT|DELETE).*'(.*)'[^R]*([^\*]*)/)
  match.each do |m|
    request = m[3].match(/Request:([^R]*)/)[1] rescue nil
    response = m[3].match(/Response:([^R]*)/)[1] rescue nil

    methods << {
      description: m[0], verb: m[1], path: "/api/v1" + m[2], 
      request: request, response: response
    }
  end
  
  # get the entities, with braces
  entities = {}
  match = contents.scan(/\*\*(@.*)\*\*[^\{]*(\{[^\}]*\})/)
  match.each do |m|
    entities[m[0]] = m[1]
  end
  
  # replace entity @tags with the entities themselves
  methods.each do |m|
    [:request, :response].each do |r|
      if m[r]
        m[r].gsub!(/@\w*/) do |s|
          entities[s]
        end

        m[r] = ActiveSupport::JSON.decode(m[r])
      end
    end
  end

  # set up some sample data
  user = FactoryGirl.create :user
  user.events << FactoryGirl.create(:past_event)
  user.events << FactoryGirl.create(:future_event)

  # correct the urls with some sample data
  params = {":facebook_id" => user.facebook_id, ":lastfm_id" => 12345}
  methods.each do |m|
    m[:path].gsub!(/\:[^\/]*/) do |s|
      params[s]
    end
  end

  # actually run the tests
  methods.each do |m|
    it "#{m[:description]}" do
      case m[:verb]
      when "GET"
        get m[:path], m[:request]
      when "POST"
        post m[:path], m[:request]
      when "PUT"
        put m[:path], m[:request]
      when "DELETE"
        delete m[:path], m[:request]
      end

      ActiveSupport::JSON.decode(last_response.body).should == m[:response]
    end
  end
end if false

# TODO: finish or maybe convert to Cucumber