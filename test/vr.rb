#!/usr/bin/env ruby
require_relative '../lib/gemfiler'

ver = Gemfiler::Versions.new(Gemfiler::Args.new(ARGV).parse).to_s
