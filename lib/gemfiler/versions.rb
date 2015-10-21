# parse rubygems.org
module Gemfiler
  class Versions
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
end
