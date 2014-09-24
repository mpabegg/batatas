RSpec::Matchers.define :be_a_json_like do |expected|
  match do |actual|
    JSON.parse(actual) == JSON.parse(expected)
  end

  diffable
end