namespace :promos_status do
  desc "Update status promos having in count end publication date"
  task update: :environment do
    Promo.where("end_at < ?", Time.now).update_all(status: :inactive)
  end
end
