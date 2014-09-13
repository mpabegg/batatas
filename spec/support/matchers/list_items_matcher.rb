RSpec::Matchers.define :be_like do |expected|
  match do |actual|
    attributes = [:product_id, :list_id, :amount, :bought]

    attributes.map { |a| actual.map(&a) }.eql? attributes.map { |a| expected.map(&a) }
  end

  diffable
end