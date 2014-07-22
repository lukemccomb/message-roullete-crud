require "rspec"
require "capybara"

feature "Messages" do
  before(:each) do
    visit "/"
  end
  scenario "As a user, I can submit a message" do

    expect(page).to have_content("Message Roullete")

    fill_in "Message", :with => "Hello Everyone!"

    click_button "Submit"

    expect(page).to have_content("Hello Everyone!")

    click_link "Edit"

    expect(page).to have_field("message", with: "Hello Everyone!")
  end

  scenario "As a user, I see an error message if I enter a message > 140 characters" do

    fill_in "Message", :with => "a" * 141

    click_button "Submit"

    expect(page).to have_content("Message must be less than 140 characters.")
  end

  scenario "User can edit messages and see changes on homepage" do

    fill_in "Message", :with => "Hello Everyone!"

    click_button "Submit"

    expect(page).to have_content("Hello Everyone!")

    click_link "Edit"

    expect(page).to have_field("message", with: "Hello Everyone!")

    fill_in "message", :with => "Hey Everybody!"

    click_button "Update"

    expect(page).to have_content("Hey Everybody!")
  end

  scenario "User can see edit messages errors" do
    fill_in "Message", :with => "Hello Everyone!"

    click_button "Submit"

    click_link "Edit"

    fill_in "message", :with => "a" * 141

    click_button "Update"

    expect(page).to have_content("Message must be less than 140 characters.")
  end

  scenario "User can delete messages" do
    fill_in "Message", :with => "Hello Everyone!"

    click_button "Submit"

    click_button "Delete"

    expect(page).to have_no_content("Hello Everyone!")
  end

  scenario "User can comment on messages" do
    fill_in "Message", :with => "Hello Everyone!"

    click_button "Submit"

    click_link "Comment"

    expect(page).to have_button("Add Comment")

    fill_in "Comment", :with => "Super fantastic!"

    click_button "Add Comment"

    expect(page).to have_button("Super fantastic!")

  end
end
