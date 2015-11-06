namespace :promos do
  desc "Create default promos"
  task create: :environment do
    (1..20).to_a.each do |f|
      Promo.create(
        name: Faker::Company.name,
        description: Faker::Company.name,
        place_id: Place.first.id,
        published: true,
        published_at: Time.now,
        role_id: 2,
        start_at: Time.now,
        end_at: Time.now + 1.month,
        extra_description: Faker::Lorem.paragraph(2),
        star_number: rand(1..5),
        category_id: 1,
        subcategory1_id: 2,
        subcategory2_id: [*3..16].sample,
        banner: Faker::Avatar.image
      )
      puts "promo #{f} created"
    end
  end
end
