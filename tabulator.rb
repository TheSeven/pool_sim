require 'core_ext'

class Tabulator
  attr_reader :data, :opts
  
  def initialize data, opts={}
    @data = data
    @opts = opts
  end
  
  def render_columns
    # this sucks, but works for now
    data.unshift opts[:headers]
    rows = data.map {|row| row.map {|elem| render_cell(elem) }}
    cols = rows.transpose
    sizes = cols.map {|col| col.map(&:size).max }
    rows.each_with_index do |row, j|
      row.each_with_index do |elem, i|
        row[i] = row[i] + ' ' * (sizes[i] - elem.size)
      end
      puts row.join(' | ')
      puts sizes.map {|s| '-' * s}.join('-+-') if j == 0
    end
  end
  
  def render_cell value
    case value
    when Float then "%0.4f" % value
    when Symbol then value.to_s.titleize
    else value.to_s
    end
  end
end