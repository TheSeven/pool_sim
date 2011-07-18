require 'pps'

class XPPS < PPS
  def initialize opts={}
    super opts
  end
  
  plot :reserves
  
  def pay_out
    mp = miner_percent
    hp = hopper_percent
    @buffer += reward
    @honest_shares += shares * mp / 100.0
    @hopper_shares += shares * hp / 100.0
    @total_reward += shares * pps_price
    if shares * pps_price < buffer
      @buffer -= shares * pps_price
      @total_paid += shares * pps_price
      @honest_earnings += shares * pps_price * mp / 100.0
      @hopper_earnings += shares * pps_price * hp / 100.0
    else
      @honest_earnings += buffer * mp / 100.0
      @hopper_earnings += buffer * hp / 100.0
      @total_paid += buffer
      @buffer = 0
    end
    @honest_payout_percentage = 100.0 * @honest_earnings / @honest_shares / pps_price
    @hopper_payout_percentage = 100.0 * @hopper_earnings / @hopper_shares / pps_price
  end
  
  def reserves
    @buffer
  end
end