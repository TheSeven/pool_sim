require 'pool_sim'
require 'prop'
require 'smpps'
require 'xpps'
require 'estimator'
require 'pps_attack'

#puts "\n=== Proportional ===\n\n"
#Prop.new.run.show_table
#
puts "\n=== SMPPS ===\n\n"
SMPPS.new.run.show_table
#
#puts "\n=== xPPS ===\n\n"
#XPPS.new.run.show_table
#
#puts "\n=== SMPPS (10% withholding) ===\n\n"
#SMPPS.new.run(:withholding_percent => 10).show_table




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




#attack_opts = {:hopper_percent => 50, :withholding_percent => 50}
#
#smpps = SMPPS.new attack_opts
#smpps.extend PPSAttack
#
#xpps = XPPS.new attack_opts
#xpps.extend PPSAttack
#
#puts "\n=== SMPPS ===\n\n"
#Estimator.new(smpps, :runs => 1000).run.analyze
#
#puts "\n=== xPPS ===\n\n"
#Estimator.new(xpps, :runs => 1000).run.analyze



#Estimator.new(Prop.new, :runs => 1000, :hop_out_at => 43.5, :hopper_percent => 200).run.analyze