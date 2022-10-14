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

  def calculate_price
    price_per_distance = @mode_of_transport.price_per_distances.select do |price_per_distance|
      price_per_distance.minimum_distance <= @service_order.total_distance &&
      price_per_distance.maximum_distance >= @service_order.total_distance
    end

    price_by_weight = @mode_of_transport.price_by_weights.select do |price_by_weight|
      price_by_weight.minimum_weight <= @service_order.weight &&
      price_by_weight.maximum_weight >= @service_order.weight
    end

    price_per_distance[0].rate+(price_by_weight[0].value*@service_order.total_distance)+@mode_of_transport.flat_rate
  end

  def calculate_deadline
    deadline = @mode_of_transport.deadlines.select do |deadline|
      deadline.minimum_distance <= @service_order.total_distance &&
      deadline.maximum_distance >= @service_order.total_distance
    end
    deadline[0].estimated_time
  end
end