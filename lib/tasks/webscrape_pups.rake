require_relative "../../app/services/lhs_webscraper.rb"

namespace :db do
    task webscrape_pups: :environment do
        puts "Scraping Humane Society..."
        webscraper = LhsWebscraper.new
        fetched_dog_info = webscraper.fetch_dogs
        new_animals = []
        old_animals = []

        fetched_dog_info.each do |dog|
            # How to make this one insert query?
            animal = Animal.find_by(lhs_id: dog["lhs_id"])

            if animal && animal.status == "adoptable"
                old_animals << animal.name
                next
            elsif animal && animal.status == "new_to_shelter"
                animal.update(status: "adoptable")
            else
                Animal.create(name: dog["name"], lhs_id: dog["lhs_id"], gender: dog["gender"], age: 2.0, image_url: dog["image_url"])
                new_animals << dog["name"]
            end
        end
        puts "Finished fetching!"
        puts "New dogs: #{new_animals.join(", ")}"
        puts "Still here: #{old_animals.join(", ")}"
    end
end
