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
end