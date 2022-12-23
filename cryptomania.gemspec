Gem::Specification.new do |s|
  s.name        = 'cryptomania'
  s.version     = '2.0'
  s.executables << 'cryptomania'
  s.summary     = "a crypto gem"
  s.description = "invest and win"
  s.authors     = ["Ajay Ghimire"]
  s.email       = 'ajayghimire1998@gmail.com'
  s.files       = ["lib/cryptomania.rb", 
                  "lib/app/crypto_list.rb", 
                  "lib/app/invested_crypto.rb", 
                  "lib/app/player.rb",
                  "lib/app/scrapper.rb",
                  "config/environment.rb",
                  "utility/Crypto_Calculator.rb",
                  "utility/FancyText.rb"]
  s.homepage    = 'https://rubygems.org/gems/cryptomania'
  s.license       = 'MIT'
  s.required_ruby_version = '>=3.1.2'

end