BASE_ANIMAL_URL = "https://www.longmonthumane.org/animals/view-animal/?animalID="

class LhsWebscraper
    def fetch_dogs
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument("--headless")

        driver = Selenium::WebDriver.for :chrome, options: options

        driver.navigate.to("https://www.longmonthumane.org/animals/")

        wait = Selenium::WebDriver::Wait.new(timeout: 10)
        wait.until { driver.find_element(:css, ".animal") }

        all_animals = driver.find_elements(css: '.animal')

        fetched_dog_info = []
        all_animals.each do |animal|
            if animal.attribute('data-species') == "Dog"
                new_dog = {}
                new_dog["name"] = animal.find_element(css: ".name").text
                new_dog["lhs_id"] = animal.find_element(css: 'a').attribute("href").delete_prefix(BASE_ANIMAL_URL)
                new_dog["gender"] = animal.attribute("data-sex").downcase
                # new_dog["age"] = animal.text
                new_dog["image_url"] = animal.find_elements(tag_name: "img").first.attribute("src")

                fetched_dog_info << new_dog
            end
        end

        driver.quit

        fetched_dog_info
    end
end
