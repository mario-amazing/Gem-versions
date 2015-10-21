#!/usr/bin/env ruby
require_relative '../lib/gemfiler'

args = Gemfiler::Args.new(ARGV)
ver = Gemfiler::Versions.new
disp = Gemfiler::Display.new
versions = ver.display_versions(args.gem_name)
disp.display_versions(versions, args.parse)
