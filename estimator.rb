require 'tabulator'

class Estimator
  attr_reader :subject, :runs, :opts
  
  def initialize subject, opts={}
    @subject = subject
    @runs = opts.delete(:runs) || 100
    @opts = opts
  end
  
  def run opts={}
    @results = []
    @opts.merge! opts
    @runs.times do
      @results << subject.run(@opts).results
    end
    self
  end
  
  def analyze
    data = all_keys.map { |key| analyze_key(key) }
    Tabulator.new(data, :headers => headers).render_columns
  end
  
  def analyze_key key
    samples = @results.map { |hash| hash[key] }
    [key, samples.mean, samples.median, samples.min, samples.max, samples.variance]
  end
  
  def headers
    ['', 'Average', 'Median', 'Min', 'Max', 'Variance']
  end
  
  def all_keys
    subject.plot_items
  end
end