# parse @argv
module Gemfiler
  class Args
    SIGN_FORMAT = /(~>|>=|<)/
    VER_FORMAT = /(\d+(?:\.[0-9A-Za-z-]+)*)/

    def initialize(argv)
      @argv = argv
    end

    def parse
      gem_name = @argv.shift
      validate_gem_name(gem_name)
      conditions = []
      @argv.each do |condition|
        sign, ver = condition.squeeze(' ').split(' ')
        validate_condition!(sign, ver)
        conditions << { sign: sign, ver: ver }
      end
      { gem_name: gem_name, conditions: conditions }
    end

    def validate_condition!(sign, ver)
      if sign.nil? || ver.nil? || sign !~ SIGN_FORMAT || ver !~ VER_FORMAT
        raise 'Wrong conditions format'
      end
    end

    def validate_gem_name(gem_name)
      if gem_name.nil?
        raise 'Wrong gem name'
      end
    end
  end
end
