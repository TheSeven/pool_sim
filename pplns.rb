require 'prop'

class PPLNS < Prop
  attr_reader :target_shares
  
  def initialize opts={}
    super opts
    @target_shares ||= difficulty / 2
  end
  
  def self.opts= opts
    super opts
    @target_shares = opts[:target_shares] if opts[:target_shares]
  end
  
  def hopper_duration
    hopper_shares = [difficulty * hop_out_at / 100.0, shares].min
    hopper_shares += target_shares - shares if shares > target_shares
    hopper_shares / shares
  end
end