require 'pool_sim'

class PPS < PoolSim
  attr_reader :buffer, :honest_earnings, :total_paid, :total_reward, :debt
  
  plot :honest_earnings, :buffer, :debt
  
  def initialize opts={}
    super opts
    @buffer = 0
    @honest_earnings = 0
    @total_paid = 0
    @total_reward = 0
    @withholding_percent = 0
  end
  
  def opts= opts
    @withholding_percent = opts[:withholding_percent] if opts[:withholding_percent]
    super opts
  end
  
  def pps_price
    50.0 / difficulty
  end
  
  def debt
    total_reward - total_paid
  end
  
  def mean_shares
    puts @withholding_percent
    p = @withholding_percent / 100.0
    difficulty * (1 + p / (1 - p))
  end
end