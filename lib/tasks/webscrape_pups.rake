require_relative "../../app/services/lhs_webscraper.rb"

namespace :db do
    task webscrape_pups: :environment do
        puts "Scraping Humane Society..."
        webscraper = LhsWebscraper.new
        fetched_dog_info = webscraper.fetch_dogs

        fetched_dog_info.each do |dog|
            # How to make this one insert query?
            # How to handle status here?
            animal = Animal.find_by(lhs_id: dog["lhs_id"])
            if animal && animal.status == "new_to_shelter"
                animal.update(status: "adoptable")
            else
                Animal.create(name: dog["name"], lhs_id: dog["lhs_id"], gender: dog["gender"], age: 2.0, image_url: dog["image_url"])
            end
        end
        puts "Finished fetching!"
    end
end
