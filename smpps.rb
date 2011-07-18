require 'pps'

class SMPPS < PPS
  def initialize opts={}
    super opts
  end
  
  plot :reserves
  
  def pay_out
    mp = miner_percent
    @buffer += reward
    @total_reward += shares * pps_price
    ideal = total_reward - total_paid
    if ideal < buffer
      @buffer -= ideal
      @total_paid += ideal
      @honest_earnings += shares * mp * pps_price / 100.0
    else
      @honest_earnings += mp * buffer / 100.0
      @total_paid += buffer
      @buffer = 0
    end
  end
  
  def reserves
    @buffer - self.debt
  end
end