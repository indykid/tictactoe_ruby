guard :rspec, cmd: "bundle exec rspec", all_after_pass: true do
  # watch /lib/ files
  watch(%r{^lib/(.+).rb$}) do |m|
    "spec/#{m[1]}_spec.rb"
  end

# watch /spec/ files
  watch(%r{^spec/(.+).rb$}) do |m|
    "spec/#{m[1]}.rb"
  end

# watch /spec/support/doubles
  watch(%r{^spec/support/doubles/(.+).rb$}) do |m|
    "spec/support/doubles/#{m[1]}.rb"
  end

end
