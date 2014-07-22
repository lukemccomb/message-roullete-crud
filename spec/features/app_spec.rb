require "rspec"
require "capybara"

feature "Messages" do
  scenario "As a user, I can submit a message" do
    visit "/"

    expect(page).to have_content("Message Roullete")

    fill_in "Message", :with => "Hello Everyone!"

    click_button "Submit"

    expect(page).to have_content("Hello Everyone!")

    click_link "Edit"

    expect(page).to have_field("message", with: "Hello Everyone!")
  end

  scenario "As a user, I see an error message if I enter a message > 140 characters" do
    visit "/"

    fill_in "Message", :with => "a" * 141

    click_button "Submit"

    expect(page).to have_content("Message must be less than 140 characters.")
  end

  scenario "User can edit messages and see changes on homepage" do
    visit "/"

    fill_in "Message", :with => "Hello Everyone!"

    click_button "Submit"

    expect(page).to have_content("Hello Everyone!")

    click_link "Edit"

    expect(page).to have_field("message", with: "Hello Everyone!")

    fill_in "message", :with => "Hey Everybody!"

    click_button "Update"

    expect(page).to have_content("Hey Everybody!")
  end

end
