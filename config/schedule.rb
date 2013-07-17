env :PATH, ENV['PATH']

every 1.minute do 
  runner "LiveEvent.perform_async"
end