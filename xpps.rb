require 'pps'

class XPPS < PPS
  def initialize opts={}
    super opts
  end
  
  def pay_out
    @buffer += reward
    @total_reward = shares * pps_price
    @total_paid = 0
    ideal = total_reward - total_paid
    if ideal < buffer
      @buffer -= ideal
      @total_paid += ideal
      @honest_earnings += shares * miner_percent * pps_price / 100.0
    else
      @honest_earnings += miner_percent * buffer / 100.0
      @total_paid += buffer
      @buffer = 0
    end
  end
  
  def debt
    0
  end
end