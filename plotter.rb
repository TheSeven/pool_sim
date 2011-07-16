require 'tabulator'

module Plotter
  def self.included(base)
    base.class_eval do
      extend ClassMethods
      include InstanceMethods
    end
    base.class_eval "def self.plot_items; @plot_items ||= (superclass.plot_items.clone rescue []); end"
    base.class_eval "def plot_items; self.class.plot_items; end"
  end
  
  module ClassMethods
    def plot *args
      plot_items.concat args
    end    
  end
  
  module InstanceMethods
    def reset_plot
      @plot = []
    end
    
    def plot_next
      @plot << plot_items.map {|item| send(item)}
    end
    
    def show_table
      Tabulator.new(@plot, :headers => plot_items).render_columns
    end
    
    def show_graph
      # TODO
    end
  end
end