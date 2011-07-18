require 'pool_sim'

class Prop < PoolSim
  
  def initialize opts={}
    super opts
  end
  
  def pay_out
    mp = miner_percent
    hp = hopper_percent
    @honest_earnings += reward * mp / 100.0
    @hopper_earnings += reward * hp / 100.0
    @honest_shares += shares * mp / 100.0
    @hopper_shares += shares * hp / 100.0
    @honest_payout_percentage = 100.0 * @honest_earnings / @honest_shares / pps_price
    @hopper_payout_percentage = 100.0 * @hopper_earnings / @hopper_shares / pps_price
  end
  
  def clear
  end
end
