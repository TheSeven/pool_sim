require 'pool_sim'

class Prop < PoolSim
  attr_reader :honest_earnings
  
  plot :honest_earnings
  
  def initialize opts={}
    super opts
  end
  
  def pay_out
    @honest_earnings += reward * miner_percent / 100.0
  end
  
  def clear
    @honest_earnings = 0.0
  end
end
