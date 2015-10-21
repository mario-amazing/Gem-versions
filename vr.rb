#!/usr/bin/env ruby
require_relative 'lib/gemfiler'
require 'gemfiler'

args = Gemfiler::Args.new
ver = Gemfiler::Versions.new
disp = Gemfiler::Display.new
versions = ver.display_versions(args.gem_name)
disp.display_versions(versions, args.gem_version)
