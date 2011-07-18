require 'pool_sim'

class Prop < PoolSim
  def initialize opts={}
    super opts
  end
  
  def pay_out
    mp = miner_percent / 100.0
    hp = hopper_percent / 100.0
    @honest_earnings += reward * mp
    @hopper_earnings += reward * hp
    @honest_shares += shares * mp
    @hopper_shares += shares * hp
  end
end
