require 'plotter'

class PoolSim
  include Plotter
  
  attr_reader :round, :rounds, :difficulty, :shares, :average_fees, :reward,
              :honest_payout_percentage, :honest_shares, :hopper_shares,
              :honest_earnings, :hopper_earnings, :hopper_payout_percentage,
              :hop_out_at, :withholding_percent, :hopper_percent,
              :share_fluctuations_percent, :invalid_percent

  plot :honest_earnings, :honest_shares, :hopper_earnings, :hopper_shares,
       :honest_payout_percentage, :hopper_payout_percentage, :round, :reward,
       :shares, :difficulty
  
  def initialize opts={}
    @rounds = 10000
    @difficulty = 1_500_000
    @miner_percent = 2
    @average_fees = 0
    @withholding_percent = 0
    @hop_out_at = 43.5
    @hopper_percent = 0
    @share_fluctuations_percent = 50
    @invalid_percent = 1
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
    @share_fluctuations_percent = opts[:share_fluctuations_percent] if opts[:share_fluctuations_percent]
    @invalid_percent = opts[:invalid_percent] if opts[:invalid_percent]
  end
  
  def run opts={}
    reset_plot
    @honest_earnings = 0.0
    @hopper_earnings = 0.0
    @honest_shares = 0.0
    @hopper_shares = 0.0
    clear
    self.opts = opts
    1.upto(rounds) do |round|
      @round = round
      do_round
      plot_next
    end
    self
  end
  
  def pps_price
    50.0 / difficulty
  end
  
  def do_round
    @shares = random_shares
    @reward = random_reward
    if rand < invalid_percent / 100.0
      @reward = 0
    end
    pay_out
  end
  
  def pay_out
    # do nothing
  end
  
  def random_reward
    50 - Math.log(rand) * average_fees
  end
  
  def ideal_earnings
    50 * round * @miner_percent / 100.0
  end
  
  def random_shares
    [(-Math.log(rand) * mean_shares).to_i, 1].max
  end
  
  def mean_shares
    p = withholding_percent / 100.0
    difficulty / (1 - p)
  end
  
  def hopper_duration
    [difficulty * hop_out_at / 100.0, shares].min / shares
  end
  
  def miner_percent
    @miner_percent / (1.0 + hopper_duration * @hopper_percent / 100.0) * (1.0 + 0.02 * share_fluctuations_percent * rand)
  end
  
  def hopper_percent
    @miner_percent * hopper_duration / (1.0 + hopper_duration * @hopper_percent / 100.0) * (1.0 + 0.02 * share_fluctuations_percent * rand)
  end
  
  def results
    {}.tap do |hash|
      plot_items.each_with_index do |item, i|
        hash[item] = @plot[-1][i]
      end
    end
  end
end
