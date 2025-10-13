require 'rails_helper'

RSpec.describe "Animals", type: :feature do
  before(:all) do
    @animal = create(:animal)
  end
  describe "GET /animals" do
    it "navigates to animals#index page" do
      visit "/animals"

      expect(page).to have_content("All Animals")
      expect(page).to have_content("Maya")
      expect(page).to have_content("9.0 year old Female Dog")
      expect(page).to have_content("Adoptable")
    end
  end

  describe "GET /animal" do
    it "navigates to animals#index page" do
      visit "/animal/#{@animal.id}"

      expect(page).to have_content("All Animals")
      expect(page).to have_content("Maya")
      expect(page).to have_content("9.0 year old Female Dog")
      expect(page).to have_content("Adoptable")
    end
  end
end
