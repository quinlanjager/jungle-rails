require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do
      @category = Category.create
    end
    it 'should validate false if there is no name' do
      @product = Product.create(name: nil, price: 200, quantity: 10, category_id: @category.id)
      expect(@product).to_not be_valid
    end

    it 'should validate false if there is no price' do
      @product = Product.create(name: "Pants", price: nil, quantity: 10, category_id: @category.id)
      expect(@product).to_not be_valid
    end

    it 'should validate false if there is no quantity' do
      @product = Product.create(name: "Pants", price:100, quantity: nil, category_id: @category.id)
      expect(@product).to_not be_valid
    end

    it 'should validate false if there is no category' do
      @product = Product.create(name: "Pants", price:100, quantity:10, category_id: nil)
      expect(@product).to_not be_valid
    end

    it 'should have the "[column] can\'t  be blank" error message if a column is missing' do
      @product = Product.new(name: "Pants", price:100, quantity:10, category_id: nil)
      @product.save
      expect(@product.errors.full_messages[0]).to include("can't be blank")
    end
  end
end
