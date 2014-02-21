#!/usr/bin/ruby

projects = IO.readlines(ARGV[0]).map{|s|
  m = s.match(/<project path="(.*?)" name="(.*?)" (groups="(.*)")?/)
  next nil unless m
  path = m[1]
  name = m[2]
  groups = m[4]

#  next nil if groups =~ /devices/ # we do not build devices
  next nil if groups =~ /darwin/  # we don't need macosx stuff
#  next nil if name =~ %r{^platform/packages/apps} # apps are not needed for sdk/build tools
  next nil if name =~ %r{^platform/hardware/} and groups !~ /pdk/ # neither hardware drivers
#  next nil if name =~ %r{^device/}
  next nil if groups =~ /notdefault/ and groups !~ /tools/
  next nil if name =~ %r{^platform/prebuilts/(gcc|clang)/}

# do we need prebuilts?

  next path + ' ' + name
}.compact
puts projects
