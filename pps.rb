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
  end
  
  def pps_price
    50.0 / difficulty
  end
  
  def debt
    total_reward - total_paid
  end
end