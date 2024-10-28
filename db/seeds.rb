require 'csv'
require 'faker'

# Ensure breeds are created from CSV
puts "Seeding breeds..."
csv_text = File.read('db/dog_breeds.csv')
csv = CSV.parse(csv_text, headers: true)

csv.each do |row|
  Breed.find_or_create_by(
    name: row['breed_name'],
    group: row['group'],
    section: row['section'],
    country: row['country'],
    url: row['url'],
    image: row['image'],
    pdf: row['pdf'],
    description: Faker::Lorem.paragraph
  )
end

# Check if breeds were created
if Breed.count > 0
  puts "Breeds seeded: #{Breed.count}"
else
  puts "No breeds were created; check CSV format or file path."
end

# Generate Owners and Dogs
puts "Creating owners and dogs..."
5.times do
  owner = Owner.create(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email
  )

  if owner.persisted?
    2.times do
      breed = Breed.all.sample
      dog = Dog.new(
        name: Faker::Creature::Dog.name,
        age: rand(1..15),
        breed_id: breed.id,  # Use breed_id instead of breed
        owner_id: owner.id   # Use owner_id instead of owner
      )
      if dog.save
        puts "Created dog: #{dog.name}, Breed: #{breed.name}, Owner: #{owner.name}"
      else
        puts "Failed to create dog: #{dog.errors.full_messages.join(', ')}"
      end
    end
  else
    puts "Failed to create owner: #{owner.errors.full_messages.join(', ')}"
  end
end

# Generate VetVisits if dogs exist
puts "Creating vet visits..."
dogs = Dog.all
if dogs.any?
  10.times do
    dog = dogs.sample
    vet_visit = VetVisit.create(
      visit_date: Faker::Date.between(from: 1.year.ago, to: Date.today),
      description: Faker::Lorem.sentence,
      dog: dog,
      vet_clinic: Faker::Company.name
    )
    if vet_visit.persisted?
      puts "Vet visit created for #{dog.name} on #{vet_visit.visit_date} at #{vet_visit.vet_clinic}"
    else
      puts "Failed to create vet visit: #{vet_visit.errors.full_messages.join(', ')}"
    end
  end
else
  puts "No dogs available to create vet visits."
end
