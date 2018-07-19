require "application_system_test_case"

class CrpytoInfosTest < ApplicationSystemTestCase
  setup do
    @crpyto_info = crpyto_infos(:one)
  end

  test "visiting the index" do
    visit crpyto_infos_url
    assert_selector "h1", text: "Crpyto Infos"
  end

  test "creating a Crpyto info" do
    visit crpyto_infos_url
    click_on "New Crpyto Info"

    fill_in "Date", with: @crpyto_info.date
    fill_in "Ticker", with: @crpyto_info.ticker
    click_on "Create Crpyto info"

    assert_text "Crpyto info was successfully created"
    click_on "Back"
  end

  test "updating a Crpyto info" do
    visit crpyto_infos_url
    click_on "Edit", match: :first

    fill_in "Date", with: @crpyto_info.date
    fill_in "Ticker", with: @crpyto_info.ticker
    click_on "Update Crpyto info"

    assert_text "Crpyto info was successfully updated"
    click_on "Back"
  end

  test "destroying a Crpyto info" do
    visit crpyto_infos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Crpyto info was successfully destroyed"
  end
end
