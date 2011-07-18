require 'pool_sim'

class PPS < PoolSim
  attr_reader :total_paid, :total_reward, :debt
  
  plot :debt, :total_reward, :total_paid
  
  def initialize opts={}
    super opts
  end
  
  def debt
    total_reward - total_paid
  end
  
  def clear
    @total_paid = 0
    @total_reward = 0
  end
end