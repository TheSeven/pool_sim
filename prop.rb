require 'pool_sim'

class Prop < PoolSim

  attr_reader :lowest_percentage

  plot :lowest_percentage
    
  def initialize opts={}
    super opts
  end
  
  def pay_out
    mp = miner_percent
    hp = hopper_percent
    pp = ppshopper_percent
    @honest_earnings += reward * mp / 100.0
    @hopper_earnings += reward * hp / 100.0
    @ppshopper_earnings += reward * pp / 100.0
    @honest_shares += shares * mp / 100.0
    @hopper_shares += shares * hp / 100.0
    @ppshopper_shares += shares * pp / 100.0
    @honest_payout_percentage = 100.0 * @honest_earnings / @honest_shares / pps_price
    @hopper_payout_percentage = 100.0 * @hopper_earnings / @hopper_shares / pps_price
    @ppshopper_payout_percentage = 100.0 * @ppshopper_earnings / @ppshopper_shares / pps_price
    if honest_payout_percentage < lowest_percentage
      @lowest_percentage = honest_payout_percentage
    end
  end
  
  def clear
    @buffer = 0.000000001
    @lowest_percentage = 100.0
  end
  
end
