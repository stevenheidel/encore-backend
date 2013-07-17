VCR.configure do |config|
  config.hook_into :faraday
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.preserve_exact_body_bytes { true }
  config.default_cassette_options = {
    re_record_interval: 1.week,
    record: :new_episodes
  }

  config.allow_http_connections_when_no_cassette = true
end

VCR.cucumber_tags do |t|
  t.tag '@vcr', use_scenario_name: true 
end