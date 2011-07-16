require 'pool_sim'
require 'prop'
require 'smpps'
require 'xpps'

puts "\n=== Proportional ===\n\n"
Prop.new.run.show_table

puts "\n=== SMPPS ===\n\n"
SMPPS.new.run.show_table

puts "\n=== xPPS ===\n\n"
XPPS.new.run.show_table