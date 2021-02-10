require "application_system_test_case"

class AcsTest < ApplicationSystemTestCase
  setup do
    @ac = acs(:one)
  end

  test "visiting the index" do
    visit acs_url
    assert_selector "h1", text: "Acs"
  end

  test "creating a Ac" do
    visit acs_url
    click_on "New Ac"

    fill_in "Mode", with: @ac.mode
    check "Status" if @ac.status
    fill_in "Temperature", with: @ac.temperature
    click_on "Create Ac"

    assert_text "Ac was successfully created"
    click_on "Back"
  end

  test "updating a Ac" do
    visit acs_url
    click_on "Edit", match: :first

    fill_in "Mode", with: @ac.mode
    check "Status" if @ac.status
    fill_in "Temperature", with: @ac.temperature
    click_on "Update Ac"

    assert_text "Ac was successfully updated"
    click_on "Back"
  end

  test "destroying a Ac" do
    visit acs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ac was successfully destroyed"
  end
end
