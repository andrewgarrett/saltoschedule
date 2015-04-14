require "rubygems"
require 'gga4r'
require 'string_population'
require 'timetable_scheduler'
require 'scheduler_population'

class SchedulesController < ApplicationController
  def index
    @x = 3
    @lessons = Lesson.all
    @equipments = Equipment.all

    @timeslot_intervals = Hash.new
    @timeslot_intervals[15] = "15 Minutes"
    @timeslot_intervals[20] = "20 Minutes"
    @timeslot_intervals[30] = "30 Minutes"
    @timeslot_intervals[45] = "45 Minutes"
    @timeslot_intervals[60] = "1 Hour"

    @interval = params[:interval].to_i
    @interval = 30 if @interval==0

    #do real scheduling
    do_timetable_scheduling (@interval)
    @background_color = ['red','blue','green','black','indigo','purple','brown','grey','deepskyblue']
  end

  #original population
  def create_population_with_fit_all_1s(s_long = 10, num = 10)
    population = []
    num.times  do
      chromosome = StringPopulation.new(Array.new(s_long).collect { (rand > 0.2) ? 0:1 })

      population << chromosome
    end
    population
  end


  def create_population_with_fit(time_slots, classes, equipments, population_size = 10)
    population = []

    num_rows = time_slots.size
    num_cols = classes.size
    num_equipments = equipments.size
    #num_rows * num_cols = individual population length
    #generate population
    population_size.times do
      chromosome = SchedulerPopulation.new(Array.new(num_rows*num_cols).collect {
          rand(num_equipments).to_i }
      )
      population << chromosome
      puts "here \n"
      chromosome.output
      puts chromosome.fitness

    end
    population
  end

  #original bitstring GA implementaion
  def do_schedule_original

    ga = GeneticAlgorithm.new(create_population_with_fit_all_1s, {:use_threads => true })
    p ga

    1.times { |i|
      ga.evolve
#  p ga.generations[-1]
      puts i
=begin
      best_fit = ga.best_fit
      puts "Num population: #{ga.generations[-1].size} - Generation: #{ga.num_generations}"
      puts "best fitness: #{best_fit[0].fitness} num fits: #{best_fit.size}"
      p ga.generations[-1]
      p best_fit[0]
      puts "mean fitness #{ga.mean_fitness} --> #{ga.mean_fitness(ga.num_generations)}"

#  p ga.generations[-1]
      sum_fitness = 0
      ga.generations[-1].each { |chromosome|
        sum_fitness += chromosome.fitness
      }

      tmp = sum_fitness.to_f / ga.generations[-1].size.to_f
      puts "mean fitness recalc #{tmp}"

      puts "*"*30
=end
    }
    p ga.best_fit[0]
  end
  #new timetable scheduling
  def do_timetable_scheduling (interval = 30)
    #second get equipments info
    $equipments_array = []
    @equipments.each_with_index do |equipment, p|
      $equipments_array <<  equipment.name
    end
    p $equipments_array
    

    #arrange classes
    $classes_array = []
    @lessons.each_with_index do |lesson, index|
      $classes_array <<  lesson.title
    end
    p $classes_array


    #arrange time_slots
    #get min_start,max_start, and individual start with 30min time interval
    all_start_time  = []
    all_end_time = []
    week_day = ['mon','tue','wed','thu','fri','sat','sun']
    @lessons.each_with_index do |lesson, index|
      #by default we deal with monday time and assumes it's same for all other days of the week
      week_day.each_with_index do |day, index|
        unless JSON.parse(lesson.start_time)[index.to_s]==0
          all_start_time << JSON.parse(lesson.start_time)[index.to_s]
        end
        unless JSON.parse(lesson.end_time)[index.to_s]==0
        all_end_time << JSON.parse(lesson.end_time)[index.to_s]
        end
      end

    end

    p all_start_time
    p all_end_time

    #$start_time = all_start_time.min() / 30
    #$end_time = all_end_time.max() / 30
    $schedule_start_time = all_start_time.min()
    $schedule_end_time = all_end_time.max()
    $start_time = 0
    #offest maxium
    $end_time = (($schedule_end_time-$schedule_start_time) / interval.to_f).ceil


    p $start_time
    p $end_time


    $time_slots = []

    #total duration is end-start by 30min slots
    duration = $end_time - $start_time

    $end_time.times do |i|
        $time_slots << i
    end

    p $time_slots

    #start timetable Scheduler
    population = {}
    ga = TimetableScheduler.new(create_population_with_fit($time_slots,$classes_array, $equipments_array),{:time_slots=>$time_slots, :classes=>$classes_array, :equipments => $equipments_array})

    #max = ga.population.max_by{|v| v.fitness}
    #p max
    #p max.fitness
    times = 0
    best_fit = 0
    until best_fit==1 || times==2000
      ga.evolve
=begin
      puts " index"
      puts i
      puts 'Result'
      p ga.population
=end
      puts "==" + times.to_s
      best_fit = ga.best_fit

      # p best_fit
      #puts "Num population: #{ga.generations[-1].size} - Generation: #{ga.num_generations}"
      puts "best fitness: #{best_fit.fitness} num fits: #{best_fit}"
      #p ga.generations[-1]
      p best_fit
      #puts "mean fitness #{ga.mean_fitness} --> #{ga.mean_fitness(ga.num_generations)}"

      #  p ga.generations[-1]
=begin
      sum_fitness = 0
      ga.generations[-1].each { |chromosome|
        sum_fitness += chromosome.fitness
      }

      tmp = sum_fitness.to_f / ga.generations[-1].size.to_f
      puts "mean fitness recalc #{tmp}"
=end
      times += 1
      puts "*"*30
    end

    ga.best_fit.output
    @best_fit = ga.best_fit

    @conflict = ga.best_fit.fitness
    #order by equipment
    @best_fit_by_equipment = []
    puts 'best fit by equipment'
    $time_slots.size().times do |t|
      $equipments_array.size().times do |e|
        range = @best_fit.values[t*$classes_array.size(), $classes_array.size()]
        classes = range.each_index.select{|i| @best_fit.values[i+t*$classes_array.size()] == e}
        if classes
          @best_fit_by_equipment << classes
        else
          @best_fit_by_equipment << '-1'
        end
      end
    end
    p @best_fit_by_equipment
  end
end
