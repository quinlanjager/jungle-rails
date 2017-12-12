require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature do
  before :each do
    @category = Category.create! name: 'Apparel'
    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They should see an item added to their cart" do
    visit root_path
    page.first(".actions").find('a:first').click
    expect(page.find('a[href="/cart"]')).to have_content('My Cart (1)')
  end
end
