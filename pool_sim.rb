require 'plotter'

class PoolSim
  include Plotter
  
  attr_reader :round, :rounds, :difficulty, :shares, :average_fees, :reward,
              :hop_out_at, :withholding_percent, :hopper_percent
  
  plot :round, :reward, :shares, :difficulty
  
  def initialize opts={}
    @rounds = 100
    @difficulty = 1_500_000
    @miner_percent = 2
    @average_fees = 0
    @withholding_percent = 0
    @hop_out_at = 43.5
    @hopper_percent = 0
    self.opts = opts
  end
  
  def opts= opts
    @rounds = opts[:rounds] if opts[:rounds]
    @difficulty = opts[:difficulty] if opts[:difficulty]
    @miner_percent = opts[:miner_percent] if opts[:miner_percent]
    @average_fees = opts[:average_fees] if opts[:average_fees]
    @withholding_percent = opts[:withholding_percent] if opts[:withholding_percent]
    @hop_out_at = opts[:hop_out_at] if opts[:hop_out_at]
    @hopper_percent = opts[:hopper_percent] if opts[:hopper_percent]
  end
  
  def run opts={}
    reset_plot
    clear
    self.opts = opts
    1.upto(rounds) do |round|
      @round = round
      do_round
      plot_next
    end
    self
  end
  
  def do_round
    @shares = random_shares
    @reward = random_reward
    pay_out
  end
  
  def pay_out
    # do nothing
  end
  
  def random_reward
    50 - Math.log(rand) * average_fees
  end
  
  def random_shares
    (-Math.log(rand) * mean_shares).to_i
  end
  
  def mean_shares
    p = withholding_percent / 100.0
    difficulty * (1 + p / (1 - p))
  end
  
  def hopper_duration
    [difficulty * hop_out_at / 100.0, shares].min / shares
  end
  
  def miner_percent
    @miner_percent * 1 / (1.0 + hopper_percent * hopper_duration / 100.0)
  end
  
  def results
    {}.tap do |hash|
      plot_items.each_with_index do |item, i|
        hash[item] = @plot[-1][i]
      end
    end
  end
end
