require 'lastfm_xml'

describe LastfmXML do
  # Mumford & Sons with 1 and 2 events
  let(:mumford1) { LastfmXML.new(File.read('spec/fixtures/files/mumford_and_sons_1.xml'), 'Mumford & Sons') }
  let(:mumford2) { LastfmXML.new(File.read('spec/fixtures/files/mumford_and_sons_2.xml'), 'Mumford & Sons') }

  # TODO: Compare to JSON of same response
  let(:bieber1) { }

  it "should convert properly" do
    mumford1.convert
  end
end