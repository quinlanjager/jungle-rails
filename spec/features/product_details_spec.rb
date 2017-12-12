require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
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

  scenario "They can navigate to the product details page from the home page and see the description" do
    visit root_path
    page.first('.actions').find_link('Details »').click
    sleep 2
    url = URI.parse(current_url).to_s
    # get the product id from the URL. 
    expect(page).to have_text(Product.find(url.split('/').last).description)
    save_screenshot "description.png"
  end
end
