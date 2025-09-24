class AnimalsController < ApplicationController
    def index
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument("--headless")

        driver = Selenium::WebDriver.for :chrome, options: options

        driver.navigate.to("https://www.longmonthumane.org/animals/")

        wait = Selenium::WebDriver::Wait.new(timeout: 10)
        wait.until { driver.find_element(:css, ".animal") }

        all_animals = driver.find_elements(css: '.animal')

        all_animals.each do |animal|
            if animal.attribute('data-species') == "Dog"
                name = animal.find_element(css: ".name").text
                lhs_id = animal.find_element(css: 'a').attribute("href").delete_prefix(BASE_ANIMAL_URL)
                gender = animal.attribute("data-sex").downcase

                new_animal = Animal.create!(name:  name, lhs_id: lhs_id, gender: gender)
            end
        end
        driver.quit
    end
end
