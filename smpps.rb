require 'pps'

class SMPPS < PPS
  attr_reader :honest_debt, :hopper_debt
  
  def initialize opts={}
    super opts
  end
  
  def pay_out
    mp = miner_percent / 100.0
    hp = hopper_percent / 100.0
    @buffer += reward
    @honest_shares += shares * mp
    @hopper_shares += shares * hp
    @honest_debt += shares * pps_price * mp
    @hopper_debt += shares * pps_price * hp
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
  end
  
  def clear
    super
    @honest_debt = 0
    @hopper_debt = 0
  end
end