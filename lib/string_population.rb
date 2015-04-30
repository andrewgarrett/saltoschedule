class StringPopulation < Array
  def fitness
    self.select { |pos| pos == 1 }.size.to_f / self.size.to_f
  end

  def recombine(c2)
    cross_point = (rand * c2.size).to_i
    c1_a, c1_b = self.split(cross_point)
    c2_a, c2_b = c2.split(cross_point)
    p c1_a, c1_b
    #[StringPopulation.new(c1_a + c2_b), StringPopulation.new(c2_a + c1_b)]
  end

  def mutate
    mutate_point = (rand * self.size).to_i
    self[mutate_point] = 1
  end

end

