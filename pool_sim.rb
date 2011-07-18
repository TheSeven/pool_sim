require 'plotter'

class PoolSim
  include Plotter
  
  POOL_OPTS = [
    :rounds, :difficulty, :miner_percent, :average_fees, :withholding_percent,
    :hop_out_at, :hopper_percent, :ppshopper_percent, :share_fluctuations_percent, :invalid_percent
  ]
  
  attr_reader :round, :shares, :reward, :honest_shares, :hopper_shares,
              :honest_earnings, :hopper_earnings, :ppshopper_earnings, :ppshopper_shares,
              :honest_payout_percentage, :hopper_payout_percentage, :ppshopper_payout_percentage
  
  attr_reader *POOL_OPTS

  plot :honest_earnings, :hopper_earnings, :ppshopper_earnings, :honest_shares, :hopper_shares, :ppshopper_shares,
       :honest_payout_percentage, :hopper_payout_percentage, :ppshopper_payout_percentage, :reward, :shares
  
  def initialize opts={}
    @rounds = 1000
    @difficulty = 1_500_000
    @miner_percent = 2
    @average_fees = 0
    @withholding_percent = 0
    @hop_out_at = 43.5
    @hopper_percent = 0
    @ppshopper_percent = 0
    @share_fluctuations_percent = 100
    @invalid_percent = 1
    self.opts = opts
  end
  
  def opts= opts
    POOL_OPTS.each do |opt|
      instance_variable_set "@#{opt}", opts[opt] if opts[opt]
    end
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
  
  def pps_price
    50.0 / difficulty
  end
  
  def invalid?
    @invalid
  end
  
  def do_round
    @shares = random_shares
    @reward = random_reward
    @invalid = (rand < invalid_percent / 100.0)
    @reward = 0 if invalid?
    pay_out
  end
  
  def clear
    @honest_earnings = 0.0
    @hopper_earnings = 0.0
    @ppshopper_earnings = 0.0
    @honest_shares = 0.0
    @hopper_shares = 0.0
    @ppshopper_shares = 0.0
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
  
  def base_hashrate
    if buffer > 0
      1.0 - (1 - hopper_duration) * @hopper_percent / 100.0
    else
      1.0 - (1 - hopper_duration) * @hopper_percent / 100.0 - @ppshopper_percent / 100.0
    end
  end
  
  def miner_percent
    @miner_percent / base_hashrate * (1.0 + 0.02 * share_fluctuations_percent * rand)
  end
  
  def hopper_percent
    @miner_percent * hopper_duration / (1.0 + @miner_percent / 100.0) * (1.0 + 0.02 * share_fluctuations_percent * rand)
  end
  
  def ppshopper_percent
    if buffer > 0
      @miner_percent / base_hashrate
    else
      0
    end
  end
  
  def results
    {}.tap do |hash|
      plot_items.each_with_index do |item, i|
        hash[item] = @plot[-1][i]
      end
    end
  end
end
