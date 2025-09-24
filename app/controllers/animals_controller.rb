class AnimalsController < ApplicationController
    def index
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument("--headless")

        driver = Selenium::WebDriver.for :chrome, options: options

        driver.navigate.to("https://www.longmonthumane.org/animals/")
    end
end
