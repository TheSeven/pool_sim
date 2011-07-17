module PPSAttack
  def withholding_percent
    (buffer > 0) ? @withholding_percent : 0
  end
  
  def hopper_percent
    (buffer > 0) ? 0 : @hopper_percent
  end
end
