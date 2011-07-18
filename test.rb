require 'pool_sim'
require 'prop'
require 'smpps7'
require 'smpps'
require 'xpps'
require 'estimator'
require 'pps_attack'

attack_opts = {:hopper_percent => 200, :withholding_percent => 20}

smpps7 = SMPPS7.new attack_opts
#smpps7.extend PPSAttack

smpps = SMPPS.new attack_opts
#smpps.extend PPSAttack

xpps = XPPS.new attack_opts
#xpps.extend PPSAttack

prop = Prop.new attack_opts
#prop.extend PPSAttack

puts "\n=== SMPPS7 ===\n\n"
Estimator.new(smpps7, :runs => 100).run.analyze

puts "\n=== SMPPS ===\n\n"
Estimator.new(smpps, :runs => 100).run.analyze

puts "\n=== xPPS ===\n\n"
Estimator.new(xpps, :runs => 100).run.analyze

puts "\n=== Prop ===\n\n"
Estimator.new(prop, :runs => 100).run.analyze