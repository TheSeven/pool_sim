require 'pps'

class ESMPPS < PPS
  attr_reader :queue
  attr_reader :queue, :lowest_percentage

  plot :lowest_percentage

  def initialize opts={}
    super opts
  end
  
  def pay_out
    mp = miner_percent / 100.0
    hp = hopper_percent / 100.0
    pp = ppshopper_percent / 100.0
    @buffer += reward
    @honest_shares += shares * mp
    @hopper_shares += shares * hp
    @ppshopper_shares += shares * pp
    @total_reward += shares * pps_price
    @queue[0] = [queue[0][0] + shares * pps_price, queue[0][1] + shares * pps_price * mp, queue[0][2] + shares * pps_price * hp, queue[0][3] + shares * pps_price * pp]
    while buffer > 0
      least = 1
      secondleast = 1
      value = [0, 0, 0, 0]
      queue.each do |key, val|
        if key < least
          secondleast = least
          least = key
          value = val
        end
      end
      if least == 1
        break
      end
      volume = [buffer, value[0] * (secondleast - least)].min
      honest = volume * value[1] / value[0]
      hopper = volume * value[2] / value[0]
      ppshopper = volume * value[3] / value[0]
      @total_paid += volume
      @honest_earnings += honest
      @hopper_earnings += hopper
      @ppshopper_earnings += ppshopper
      @buffer -= volume
      newkey = least + volume / value[0]
      if newkey < 1
        @queue[newkey] = [queue[newkey][0] + value[0] - volume, queue[newkey][1] + value[1] - honest, queue[newkey][2] + value[2] - hopper, queue[newkey][3] + value[3] - ppshopper]
      end
      @queue.delete(least)
    end
    @honest_payout_percentage = 100.0 * @honest_earnings / @honest_shares / pps_price
    @hopper_payout_percentage = 100.0 * @hopper_earnings / @hopper_shares / pps_price
    @ppshopper_payout_percentage = 100.0 * @ppshopper_earnings / @ppshopper_shares / pps_price
    if honest_payout_percentage < lowest_percentage
      @lowest_percentage = honest_payout_percentage
    end
  end
  
  def reserves
    @buffer
  end
  
  def clear
    super
    @queue = Hash.new([0, 0, 0, 0])
    @lowest_percentage = 100.0
  end
    
end