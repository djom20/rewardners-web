namespace :grape do
  desc 'Print compiled grape routes'
  task :routes => :environment do
    Rewardners::Root.routes.each do |route|
      puts route
    end
  end
end
