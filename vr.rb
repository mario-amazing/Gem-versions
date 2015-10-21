#!/usr/bin/env ruby
require 'Gemfiler'

args = Gemfiler::Args.new
ver = Gemfiler::Versions.new
disp = Gemfiler::Display.new
versions = ver.display_versions(args.gem_name)
disp.display_versions(versions, args.gem_version)
