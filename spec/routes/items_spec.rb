require 'spec_helper'

describe Item do

  before :each do
    List.each(&:destroy)
    Product.each(&:destroy)
  end

  describe 'POST /lists/:list_id/items' do
    
  end
end