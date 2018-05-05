source 'https://rubygems.org'

gem 'rails',        '5.1.4'
gem 'puma',         '3.9.1'
gem 'sass-rails',   '5.0.6'
gem 'uglifier',     '3.2.0'
gem 'coffee-rails', '4.2.2'
gem 'jquery-rails', '4.3.1'
gem 'turbolinks',   '5.0.1'
gem 'jbuilder',     '2.7.0'

# gems afegides
gem 'rack-cors'                       # cors
gem 'email_address', '~> 0.1.8'       # validació de correus electrònics
gem 'bcrypt', '~> 3.1', '>= 3.1.11'   # hashing de contrassenyes
gem 'knock'                           # tokens de login
gem 'countries'                       # validació de països
gem 'shrine'                          # inclusió de fitxers als models (...)
gem 'fastimage'                       # dependències de shrine
gem 'image_processing'                # dependències de shrine
gem 'mini_magick'                     # dependències de shrine
gem 'geocoder'                        # informació d'ubicació geogràfica
gem 'active_model_serializers'        # serialització de models
gem 'rails-erd', group: :development  # generació de diagrama de la BD
gem  'json'                           
gem  'httparty'                       
# fi gems afegides

group :development, :test do
  gem 'sqlite3', '1.3.13'
  gem 'byebug',  '9.0.6', platform: :mri
end

group :development do
  gem 'web-console',           '3.5.1'
  gem 'listen',                '3.1.5'
  gem 'spring',                '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'
end

group :production do
  gem 'pg', '0.20.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

ruby "2.5.0"