# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :rspec, zeus: true, bundler: false do
  watch(%r{^spec/.+_spec\.rb})  
  watch(%r{^lib/(.+)\.rb})                           { |m| "spec/lib/#{m[1]}_spec.rb" }  
  watch('spec/spec_helper.rb')                       { "spec" }  
  
  # Rails example  
  watch('spec/spec_helper.rb')                       { "spec" }  
  #watch('config/routes.rb')                          { "spec/routing" }  
  watch('app/controllers/application_controller.rb') { "spec/controllers" }  
  watch(%r{^spec/.+_spec\.rb})  
  watch(%r{^app/(.+)\.rb})                           { |m| "spec/#{m[1]}_spec.rb" }  
  watch(%r{^lib/(.+)\.rb})                           { |m| "spec/lib/#{m[1]}_spec.rb" }  
  watch(%r{^app/controllers/(.+)_(controller)\.rb})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb",  "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }

  # Capybara features specs
  watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/features/#{m[1]}_spec.rb" }
end

guard :bundler do
  watch('Gemfile')
end

guard :rails, zeus: true, port: 9283 do
  watch('Gemfile.lock')
  watch(%r{^(config|lib)/.*})
end