require_relative "../../app/services/lhs_webscraper.rb"

namespace :db do
    task webscrape_pups: :environment do
        task_started = Time.now
        puts "Scraping Humane Society..."
        webscraper = LhsWebscraper.new
        fetched_dog_info = webscraper.fetch_dogs
        new_animals = []
        old_animals = []
        returned_animals = []

        # How to make this one insert query?
        fetched_dog_info.each do |dog|
            animal = Animal.find_by(lhs_id: dog["lhs_id"])

            if animal && animal.status == "adopted"
                animal.update(status: "adoptable")
                returned_animals << animal.name
            elsif animal && dog["image_url"] != "https://g.petango.com/shared/Photo-Not-Available-dog.gif" && animal.image_url == "https://g.petango.com/shared/Photo-Not-Available-dog.gif"
                animal.update(image_url: dog["image_url"])
                old_animals << animal.name
            elsif animal && animal.status == "adoptable"
                animal.update(updated_at: task_started)
                old_animals << animal.name
            elsif animal && animal.status == "new_to_shelter"
                animal.update(status: "adoptable")
                old_animals << animal.name
            elsif animal == nil
                Animal.create(name: dog["name"], lhs_id: dog["lhs_id"], gender: dog["gender"], age: dog["age"], image_url: dog["image_url"])
                new_animals << dog["name"]
            end
        end
        newly_adopted_animals = Animal.where("updated_at < ?", task_started).where.not(status: "adopted").update(status: "adopted")

        puts "Finished fetching!"
        puts "Newly Adopted: #{newly_adopted_animals.pluck(:name).join(", ")}"
        puts "New dogs: #{new_animals.join(", ")}"
        puts "Still here: #{old_animals.sort.join(", ")}"
        puts "Returned: #{returned_animals.join(", ")}"
    end
end
