# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.precompile += %w(
                                                  promos/content.js
                                                  promos/promo/show.js
                                                  promos/form.js
                                                  shared/places.js
                                                  shared/users.js
                                                  landing/index/index.js
                                                  landing/business/index.js
                                                  landing.css
                                                )
Rails.application.config.assets.paths << "#{Rails.root}/app/assets/videos"
