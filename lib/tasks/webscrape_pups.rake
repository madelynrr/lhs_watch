require_relative "../../app/services/lhs_webscraper.rb"

namespace :db do
    task webscrape_pups: :environment do
        task_started = Time.now
        puts "Scraping Humane Society..."
        webscraper = LhsWebscraper.new
        fetched_dog_info = webscraper.fetch_dogs
        new_animals = []
        old_animals = []

        # How to make this one insert query?
        fetched_dog_info.each do |dog|
            animal = Animal.find_by(lhs_id: dog["lhs_id"])

            if animal && animal.status == "adoptable"
                animal.update(updated_at: task_started)
                old_animals << animal.name
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
