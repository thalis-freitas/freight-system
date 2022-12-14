class ModeOfTransportFinder
  def initialize(mode_of_transport, service_order)
    @mode_of_transport = mode_of_transport
    @service_order = service_order
  end

  def compatible?
    @mode_of_transport.minimum_distance <= @service_order.total_distance &&
      @mode_of_transport.maximum_distance >= @service_order.total_distance &&
      @mode_of_transport.minimum_weight <= @service_order.weight &&
      @mode_of_transport.maximum_weight >= @service_order.weight
  end

  def price_per_distance
    @mode_of_transport.price_per_distances.select do |pd|
      pd.minimum_distance <= @service_order.total_distance &&
        pd.maximum_distance >= @service_order.total_distance
    end
  end

  def price_by_weight
    @mode_of_transport.price_by_weights.select do |pw|
      pw.minimum_weight <= @service_order.weight &&
        pw.maximum_weight >= @service_order.weight
    end
  end

  def calculate_price
    price_per_distance[0]
      .rate + (price_by_weight[0].value * @service_order.total_distance) + @mode_of_transport.flat_rate
  end

  def calculate_deadline
    deadline = @mode_of_transport.deadlines.select do |d|
      d.minimum_distance <= @service_order.total_distance &&
        d.maximum_distance >= @service_order.total_distance
    end
    deadline[0].estimated_time
  end
end
