#!/usr/bin/env ruby
require 'mechanize'
require 'colorize'
require 'pry'
require 'slop'

# parse rubygems.org
module GemVersions
  def gem_versions_all(gem_name)
    agent = Mechanize.new
    versions = []
    work_link = agent.get("https://rubygems.org/gems/#{gem_name}/versions")
    (work_link / '.t-list__item').each do |version|
      versions << Gem::Version.new(version.children.to_s)
    end
    versions
  rescue
    puts 'Gem not found or unable to connect to the internet.Try again.'
    exit
  end
end

# parse argv
module ParsARGV
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

# display versions
module DisplayParsVersions
  def display_versions(ver_all, ver_gem = [])
    case
    when ver_gem[0] == '~>'
      ver_all.each do |ver|
        if ver == ver_gem[1]
          puts ver.to_s.red
        else
          puts ver.to_s.green
        end
      end
    when ver_gem[0] == '>=' && ver_gem[2].nil?
      ver_all.each do |ver|
        if ver >= ver_gem[1]
          puts ver.to_s.red
        else
          puts ver.to_s.green
        end
      end
    when ver_gem[0] == '>=' && ver_gem[2] == '<'
      ver_all.each do |ver|
        if ver >= ver_gem[1] && ver < ver_gem[3]
          puts ver.to_s.red
        else
          puts ver.to_s.green
        end
      end
    else
      ver_all.each { |ver| puts ver.to_s.green }
    end
  end

  def to_gem_ver(ver_arr)
    ver_arr.map { |ver| Gem::Version.new(ver) }
    ver_arr
  end
end

# inspect gem versions
class ParseGemVersions
  include GemVersions
  include ParsARGV
  include DisplayParsVersions
end

a = ParseGemVersions.new
versions = a.gem_versions_all(a.gem_name)
a.display_versions(versions, a.gem_version)
