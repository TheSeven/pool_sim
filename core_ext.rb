class String
  def titleize
    split('_').map(&:capitalize).join(' ')
  end
end

class Array
  def sum
    sum = nil
    each do |elem|
      if sum
        sum += elem
      else
        sum = elem
      end
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
end