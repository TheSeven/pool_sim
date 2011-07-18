require 'pool_sim'

class PPS < PoolSim
  attr_reader :buffer, :total_paid, :total_reward, :debt
  
  plot :reserves, :total_reward, :total_paid
  
  def initialize opts={}
    super opts
  end
  
  def debt
    total_reward - total_paid
  end
  
  def clear
    @buffer = 0
    @total_paid = 0
    @total_reward = 0
  end
  
  def reserves
    buffer - debt
  end
end