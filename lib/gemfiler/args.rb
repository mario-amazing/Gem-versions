# parse argv
module Gemfiler
  class Args
    def gem_name
      if ARGV.first.nil? || !(ARGV.first =~ /[^-A-z]/).nil?
        puts 'You missed the name of gem or used invalid characters.Try again.'
        puts 'Usage: gemver.rb [gem name] [gem version]*'
        puts '* - optional params, in a format compatible with Gemfile'
        exit
      else
        ARGV.first.downcase
      end
    end

    def gem_version
      params =
        ("#{ARGV[1]}".scan(/(~>|>=|<)\s+(\d+(?:\.[0-9A-Za-z-]+)*)/)).flatten
      params +=
        ("#{ARGV[2]}".scan(/(<)\s+(\d+(?:\.[0-9A-Za-z-]+)*)/)).flatten
      params[1] = Gem::Version.new(params[1]) if !params[1].nil?
      params[3] = Gem::Version.new(params[3]) if !params[3].nil?
      params
    end
  end
end
