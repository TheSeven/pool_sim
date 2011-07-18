require 'pps'

class SMPPS < PPS
  attr_reader :honest_debt, :hopper_debt, :ppshopper_debt, :lowest_percentage

  plot :lowest_percentage
  
  def initialize opts={}
    super opts
  end
  
  def pay_out
    mp = miner_percent / 100.0
    hp = hopper_percent / 100.0
    pp = ppshopper_percent / 100.0
    @buffer += reward
    @honest_shares += shares * mp
    @hopper_shares += shares * hp
    @ppshopper_shares += shares * pp
    @honest_debt += shares * pps_price * mp
    @hopper_debt += shares * pps_price * hp
    @ppshopper_debt += shares * pps_price * pp
    @total_reward += shares * pps_price
    ideal = total_reward - total_paid
    if ideal < buffer
      @honest_earnings += honest_debt
      @hopper_earnings += hopper_debt
      @ppshopper_earnings += ppshopper_debt
      @honest_debt = 0
      @hopper_debt = 0
      @ppshopper_debt = 0
      @total_paid += ideal
      @buffer -= ideal
    else
      @honest_earnings += buffer / ideal * honest_debt
      @hopper_earnings += buffer / ideal * hopper_debt
      @ppshopper_earnings += buffer / ideal * ppshopper_debt
      @honest_debt -= buffer / ideal * honest_debt
      @hopper_debt -= buffer / ideal * hopper_debt
      @ppshopper_debt -= buffer / ideal * ppshopper_debt
      @total_paid += buffer
      @buffer = 0
    end
    if honest_shares == 0
      @honest_shares = 1
    end
    if hopper_shares == 0
      @hopper_shares = 1
    end
    if ppshopper_shares == 0
      @ppshopper_shares = 1
    end
    @honest_payout_percentage = 100.0 * @honest_earnings / @honest_shares / pps_price
    @hopper_payout_percentage = 100.0 * @hopper_earnings / @hopper_shares / pps_price
    @ppshopper_payout_percentage = 100.0 * @ppshopper_earnings / @ppshopper_shares / pps_price
    if honest_payout_percentage < lowest_percentage
      @lowest_percentage = honest_payout_percentage
    end
  end
  
  def clear
    super
    @honest_debt = 0
    @hopper_debt = 0
    @ppshopper_debt = 0
    @lowest_percentage = 100.0
  end
end