require 'pps'

class SMPPS < PPS
  alias_method :clear_parent, :clear

  attr_reader :honest_debt, :hopper_debt

  plot :reserves
  
  def initialize opts={}
    super opts
  end
  
  def pay_out
    mp = miner_percent
    hp = hopper_percent
    @buffer += reward
    @honest_shares += shares * mp / 100.0
    @hopper_shares += shares * hp / 100.0
    @honest_debt += shares * pps_price * mp / 100.0
    @hopper_debt += shares * pps_price * hp / 100.0
    @total_reward += shares * pps_price
    ideal = total_reward - total_paid
    if ideal < buffer
      @honest_earnings += honest_debt
      @hopper_earnings += hopper_debt
      @honest_debt = 0
      @hopper_debt = 0
      @total_paid += ideal
      @buffer -= ideal
    else
      @honest_earnings += buffer / ideal * honest_debt
      @hopper_earnings += buffer / ideal * hopper_debt
      @honest_debt -= buffer / ideal * honest_debt
      @hopper_debt -= buffer / ideal * hopper_debt
      @total_paid += buffer
      @buffer = 0
    end
    @honest_payout_percentage = 100.0 * @honest_earnings / @honest_shares / pps_price
    @hopper_payout_percentage = 100.0 * @hopper_earnings / @hopper_shares / pps_price
  end
  
  def clear
    clear_parent
    @honest_debt = 0
    @hopper_debt = 0
  end
end