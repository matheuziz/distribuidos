require "application_system_test_case"

class LightsTest < ApplicationSystemTestCase
  setup do
    @light = lights(:one)
  end

  test "visiting the index" do
    visit lights_url
    assert_selector "h1", text: "Lights"
  end

  test "creating a Light" do
    visit lights_url
    click_on "New Light"

    fill_in "Brightness", with: @light.brightness
    fill_in "Color", with: @light.color
    click_on "Create Light"

    assert_text "Light was successfully created"
    click_on "Back"
  end

  test "updating a Light" do
    visit lights_url
    click_on "Edit", match: :first

    fill_in "Brightness", with: @light.brightness
    fill_in "Color", with: @light.color
    click_on "Update Light"

    assert_text "Light was successfully updated"
    click_on "Back"
  end

  test "destroying a Light" do
    visit lights_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Light was successfully destroyed"
  end
end
