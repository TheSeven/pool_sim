require 'pool_sim'
require 'prop'
require 'esmpps'
require 'smpps'
require 'xpps'
require 'estimator'
require 'pps_attack'

attack_opts = {:hopper_percent => 3, :ppshopper_percent => 2, :withholding_percent => 1}

esmpps = ESMPPS.new attack_opts
#esmpps.extend PPSAttack

smpps = SMPPS.new attack_opts
#smpps.extend PPSAttack

xpps = XPPS.new attack_opts
#xpps.extend PPSAttack

prop = Prop.new attack_opts
#prop.extend PPSAttack

puts "\n=== ESMPPS ===\n\n"
Estimator.new(esmpps, :runs => 100).run.analyze

puts "\n=== SMPPS ===\n\n"
Estimator.new(smpps, :runs => 100).run.analyze

puts "\n=== xPPS ===\n\n"
Estimator.new(xpps, :runs => 100).run.analyze

puts "\n=== Prop ===\n\n"
Estimator.new(prop, :runs => 100).run.analyze