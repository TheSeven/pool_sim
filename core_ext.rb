class String
  def titleize
    split('_').map(&:capitalize).join(' ')
  end
end

class Array
  def sum
    return nil if empty?
    sum = 0.0
    each do |elem|
      sum += elem
    end
    sum
  end
  
  def mean
    return nil if empty?
    sum.to_f / size
  end
  
  def median
    return nil if empty?
    sorted = sort
    m = size / 2
    if size % 2 == 0
      (sorted[m-1] + sorted[m]) / 2
    else
      sorted[m]
    end
  end

  def variance
    return nil if empty?
    sum = 0.0
    m = mean
    each do |elem|
      sum += (elem - m) ** 2
    end
    sum / size
  end

  def std_dev
    Math.sqrt(variance)
  end
end