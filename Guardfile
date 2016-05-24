# More info at https://github.com/guard/guard#readme

ignore %r{/public/}

guard :bundler do
  require 'guard/bundler'
  require 'guard/bundler/verify'
  helper = Guard::Bundler::Verify.new

  files = ['Gemfile']
  files += Dir['*.gemspec'] if files.any? { |f| helper.uses_gemspec?(f) }

  # Assume files are symlinked from somewhere
  files.each { |file| watch(helper.real_path(file)) }
end

guard :minitest do
  watch(%r{^app/(.+)\.rb$}) do |m|
    "test/#{m[1]}_test.rb"
  end
  watch(%r{^app/controllers/application_controller\.rb$}) do
    'test/controllers'
  end
  watch(%r{^app/controllers/(.+)_controller\.rb$}) do |m|
    "test/integration/#{m[1]}_test.rb"
  end
  watch(%r{^lib/(.+)\.rb$}) do |m|
    "test/lib/#{m[1]}_test.rb"
  end
  watch(%r{^test/.+_test\.rb$})
  watch(%r{^test/test_helper\.rb$}) { 'test' }
end

guard :rubocop do
  watch(/.+\.rb$/)
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end

guard 'annotate' do
  watch('db/schema.rb')
  watch('app/models/**/*.rb')

  # Uncomment the following line if you are running routes annotation
  # with the ":routes => true" option
  # watch( 'config/routes.rb' )
end
