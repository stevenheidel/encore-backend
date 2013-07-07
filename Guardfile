guard :bundler do
  watch('Gemfile')
end

guard :cucumber, command_prefix: 'zeus', cli: '--profile guard', bundler: false do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$})          { 'features' }
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }

  watch(%r{^config/cucumber.yml$})          { 'features' }
end

guard :rails, zeus: true, port: 3000 do
  watch('Gemfile.lock')
  watch(%r{^(config|lib)/.*})
end

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

  # API v1 for rails
  watch(%r{^app/controllers/api/v1/(.+)_(controller)\.rb}) { |m| "spec/api/v1/#{m[1]}_spec.rb" } 

  # Capybara features specs
  watch(%r{^app/views/(.+)/.*\.(erb|haml)$})         { |m| "spec/features/#{m[1]}_spec.rb" }
end

guard 'shell' do
  watch(/index.litcoffee/) {|m| `docco -l parallel #{m[0]} -o public/docs` }
end