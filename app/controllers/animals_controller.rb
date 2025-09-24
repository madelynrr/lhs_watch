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
            end
        end
    end
end
