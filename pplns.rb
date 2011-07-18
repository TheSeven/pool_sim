require 'pool_sim'

class PPLNS < PoolSim
  attr_reader :target_shares, :honest_earnings
  
  def initialize opts={}
    super opts
    @target_shares ||= difficulty / 2
  end
  
  def self.opts= opts
    super opts
    @target_shares = opts[:target_shares] if opts[:target_shares]
  end
  
  def pay_out
    @honest_earnings += reward * miner_percent / 100.0
  end
  
  def clear
    @honest_earnings = 0
  end
  
  def pps_price
    reward / target_shares
  end
  
  def hopper_duration
    hopper_shares = [difficulty * hop_out_at / 100.0, shares].min
    hopper_shares += target_shares - shares if shares > target_shares
    hopper_shares / shares
  end
end