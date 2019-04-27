require 'yaml'
require 'pry'
require 'dijkstra'

class MetroInfopoint
  def initialize(path_to_timing_file: './config/timing4.yml', path_to_lines_file: './config/config.yml')
    @path_to_timing_file = path_to_timing_file
    @path_to_lines_file = path_to_lines_file
  end

  def metro_timing
    YAML.load_file(@path_to_timing_file)['timing']
  end

  def metro_lines
    YAML.load_file(@path_to_lines_file)
  end

  def metro_timing_graph
    data = timing
    data.collect do |element|
     [element['start'].to_s, element['end'].to_s, element['time'].to_f]
    end
  end

  def metro_price_graph
    data = timing
    data.collect do |element| 
     [elementl['start'].to_s, element['end'].to_s, element['price'].to_f]
    end
  end

  def calculate(from_station:, to_station:)
    { price: calculate_price(from_station: from_station, to_station: to_station),
      time: calculate_time(from_station: from_station, to_station: to_station) }
  end


  def calculate_price(from_station:, to_station:)
    gr = metro_price_graph
    ob = Dijkstra.new(from_station, to_station, gr)
    ob.cost
  end


  def calculate_time(from_station:, to_station:)
    gr = metro_timing_graph
    ob = Dijkstra.new(from_station, to_station, gr)
    ob.cost
  end
end
