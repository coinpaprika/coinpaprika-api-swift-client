#
# Be sure to run `pod lib lint CoinpaprikaAPI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CoinpaprikaAPI'
  s.version          = '2.1.1'
  s.summary          = 'Full market data from the world of crypto: coin prices, volumes, market caps, ATHs, return rates and more.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  This library provides a convenient way to use Coinpaprika.com API in Swift.

  Our main features include:
  * Full market data from the world of crypto: coin prices, volumes, market caps, ATHs, return rates and more.
  * Most Common Cryptocurrencies like – Bitcoin, Ethereum, Bitcoin Cash, Ripple, Litecoin, EOS, Cardano Monero Dash, etc.
  * 1500+ cryptocurrencies & tokens available – every coin you can find on coinpaprika is available in API.
                       DESC

  s.homepage         = 'https://github.com/coinpaprika/coinpaprika-api-swift-client'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Dominique Stranz' => 'dstranz@greywizard.com' }
  s.source           = { :git => 'https://github.com/coinpaprika/coinpaprika-api-swift-client.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/coinpaprika'
  s.documentation_url = 'https://coinpaprika.github.io/coinpaprika-api-swift-client/'

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.watchos.deployment_target = '3.0'
  s.tvos.deployment_target = '10.0'

  s.swift_versions = ['4.2', '5.0']
  s.cocoapods_version = '> 1.6.1'
  
  s.subspec 'Networking' do |sp|
      sp.source_files = 'CoinpaprikaAPI/Classes/Networking/**/*.swift'
  end
  
  s.subspec 'Client' do |sp|
      sp.source_files = 'CoinpaprikaAPI/Classes/Client/**/*.swift'
      sp.dependency 'CoinpaprikaAPI/Networking'
  end
  
  s.default_subspec = 'Client'
end
