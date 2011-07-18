require 'pps'

class XPPS < PPS

  alias_method :clear_parent, :clear

  attr_reader :lowest_percentage

  plot :reserves, :lowest_percentage

  def initialize opts={}
    super opts
  end
  
  def pay_out
    mp = miner_percent

    hp = hopper_percent
    pp = ppshopper_percent
    @buffer += reward
    @honest_shares += shares * mp / 100.0
    @hopper_shares += shares * hp / 100.0
    @ppshopper_shares += shares * pp / 100.0
    @total_reward += shares * pps_price
    if shares * pps_price < buffer
      @buffer -= shares * pps_price
      @total_paid += shares * pps_price
      @honest_earnings += shares * pps_price * mp / 100.0
      @hopper_earnings += shares * pps_price * hp / 100.0
      @ppshopper_earnings += shares * pps_price * pp / 100.0
    else
      @honest_earnings += buffer * mp / 100.0
      @hopper_earnings += buffer * hp / 100.0
      @ppshopper_earnings += buffer * pp / 100.0
      @total_paid += buffer
      @buffer = 0
    end
    @honest_payout_percentage = 100.0 * @honest_earnings / @honest_shares / pps_price
    @hopper_payout_percentage = 100.0 * @hopper_earnings / @hopper_shares / pps_price
    @ppshopper_payout_percentage = 100.0 * @ppshopper_earnings / @ppshopper_shares / pps_price
    if honest_payout_percentage < lowest_percentage
      @lowest_percentage = honest_payout_percentage
    end
  end
  
  def reserves
    @buffer
  end
  
  def clear
    clear_parent
    @lowest_percentage = 100.0
  end
end