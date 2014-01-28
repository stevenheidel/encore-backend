Then(/^the JSON response should have (\d+) copies similar to this under "(.*?)":$/) do |copies, json_path, json|
  expected = JSON.parse(json)
  results = JsonPath.new(json_path).on(JSON.parse(last_response.body))

  results[0].length.should == copies.to_i
  results[0].each do |result|
    result.keys.should == expected.keys
  end
end

Then(/^the JSON response should have more than (\d+) copies similar to this under "(.*?)":$/) do |copies, json_path, json|
  expected = JSON.parse(json)
  results = JsonPath.new(json_path).on(JSON.parse(last_response.body))

  results[0].length.should > copies.to_i
  results[0].each do |result|
    result.keys.should == expected.keys
  end
end

Then(/^the JSON response should have something similar to the following under "(.*?)":$/) do |json_path, json|
  expected = JSON.parse(json)
  result = JsonPath.new(json_path).on(JSON.parse(last_response.body))

  result[0].keys.should == expected.keys
end

Then(/^the JSON response should have the following under "(.*?)":$/) do |json_path, json|
  expected = JSON.parse(json)
  result = JsonPath.new(json_path).on(JSON.parse(last_response.body))

  result[0].should == expected
end

When(/^I wait for the worker "(.*?)" to process the job queue$/) do |worker|
  worker.constantize.drain
end

Given(/^the "(.*?)" job queue is empty$/) do |worker|
  worker.constantize.jobs.clear
end

Given 'the time is $time' do |time|
  Timecop.freeze Time.parse(time)
end
