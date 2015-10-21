# display versions
module Gemfiler
  class Display
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
  end
end
