class SchedulerPopulation
  #we need time_slots, classes, equipments
  attr_accessor :values
  @values
  def initialize(init_values)
    if init_values
      @values = init_values
    else
      @values = []
    end

  end

  #prints schedulerpopulation
  def output
    start = 0
=begin
     $time_slots
     $start_time
     $equipments_array
     $classes_array
=end
    $time_slots.size.times do
        p @values[start,$classes_array.size]
        start += $classes_array.size
    end
  end

  def fitness
    value = 0
    start = 0
    $time_slots.size.times do
       value += @values[start,$classes_array.size].uniq.size.to_f/$classes_array.size
      start += $classes_array.size
    end
    value / $time_slots.size
  end
  # display number of conflicts
  def number_of_conflicts
    p (1.0-self.fitness) * $time_slots.size * $classes_array.size
    ((1.0-self.fitness) * $time_slots.size * $classes_array.size).round.to_i
  end

  def recombine(c2) #crossover
    p self
    p c2
    cross_point = rand(c2.values.size-1).to_i
    p cross_point
    c1_a, c1_b = @values[0,cross_point],@values[cross_point,@values.size()]
    c2_a, c2_b = c2.values[0,cross_point],c2.values[cross_point,c2.values.size()]
    p c1_a, c1_b
    [SchedulerPopulation.new(c1_a + c2_b), SchedulerPopulation.new(c2_a + c1_b)]
  end

  def mutate
    mutate_point = (rand * @values.size).to_i
    #set random value among equipments for selected location...
    @values[mutate_point] = 1

  end

end