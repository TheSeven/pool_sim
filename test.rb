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

puts "\n=== SMPPS (10% withholding) ===\n\n"
SMPPS.new.run(:withholding_percent => 10).show_table


#puts "\n=== Proportional (0% hoppers) ===\n\n"
#Prop.new.run(:hopper_percent => 0).show_table
#
#puts "\n=== Proportional (50% hoppers) ===\n\n"
#Prop.new.run(:hopper_percent => 50).show_table
#
#puts "\n=== Proportional (100% hoppers) ===\n\n"
#Prop.new.run(:hopper_percent => 100).show_table
#
#puts "\n=== Proportional (200% hoppers) ===\n\n"
#Prop.new.run(:hopper_percent => 200).show_table
