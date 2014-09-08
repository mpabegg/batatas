require 'spec_helper'

describe Product do


  describe '#with_name' do
    let(:name) { 'Potatoe' }

    context 'when the product with name already exists' do
      before :each do
        @potatoe = Product.create(name: name)
      end

      it 'finds the it' do
        expect(Product.with_name(name).id).to eq @potatoe.id
      end
    end

    context "when there's no product with name" do
      it 'creates it' do
        expect(Product.with_name(name)).not_to be_nil
      end
    end

  end
end