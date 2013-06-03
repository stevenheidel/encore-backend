# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :rspec, zeus: true, bundler: false, :spec_paths => ["spec", "lib"] do
  watch(%r{^spec/.+_spec\.rb$})
  watch('spec/spec_helper.rb')  { "spec" }

  # Lib files
  watch(%r{^lib/(.+)\.rb$})     { |m| "lib/#{m[1]}_spec.rb" }
  watch(%r{^lib/.+_spec\.rb$})

  # Rails example
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/(.*)(\.erb|\.haml)$})                 { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  watch('config/routes.rb')                           { "spec/routing" }
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }

  # Capybara features specs
  watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/features/#{m[1]}_spec.rb" }
end

guard :bundler do
  watch('Gemfile')
end

guard :rails, zeus: true do
  watch('Gemfile.lock')
  #watch(%r{^(config|lib)/.*})
  watch(%r{^(config)/.*})
end