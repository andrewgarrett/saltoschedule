class LessonsController < ApplicationController


  before_action :authenticate_user!, only: [:index, :new, :edit ]
  #before_action :set_lesson, only: [:show, :edit, :update, :destroy]


  before_filter :get_json_variables, only: [:index, :edit, :new]
  def index
    @lessons    = current_user.lessons
    @equipments = current_user.equipments
  end

  def show
    @lesson = Lesson.find(params[:id])
  end

  def new
    #@lesson = current_user.lessons.new
    @equipments = current_user.equipments
    @lesson = current_user.lessons.new
  end

  def edit
    @equipments = current_user.equipments
    @lesson = Lesson.find(params[:id])
  end

  def create

    @lesson = Lesson.new(lesson_params)
    @lesson.user_id = current_user.id
    @lesson.schedule_repeat = params[:schedule_repeat]
    #create json format for hash
    #warm up
    warm_up = Hash.new
    warm_up[:equipment] =  params[:warmup_event]
    warm_up[:duration] = params[:warmup_duration]

    #condititioning
    conditioning = Hash.new
    conditioning[:equipment] = params[:conditioning_event]
    conditioning[:duration]  = params[:conditioning_duration]
    #events
    events = Array.new
    for i  in 0...params[:events].length
       event_data = Hash.new
      event_data[:equipment] = params[:events][i]
      event_data[:min_use_duration] =params[:event_min_duration][i]
      event_data[:max_use_duration] =params[:event_max_duration][i]
      event_data[:total_use_duration] = params[:event_duration][i]
      events.push(event_data)
    end

    #start and end time

    start_time = Hash.new
    end_time = Hash.new


    week_day = ['mon','tue','wed','thu','fri','sat','sun']
    for day in 0..6

      if(params[:chk_schedule][week_day[day].to_sym].to_i==1)
        first_key = week_day[day]+'(4i)'
        second_key = week_day[day]+'(5i)'
        start_time[day]= params[:start_time][first_key].to_i* 60+ params[:start_time][second_key].to_i
        end_time[day]  = params[:end_time][first_key].to_i* 60+ params[:end_time][second_key].to_i
      else
        start_time[day]= 0
        end_time[day]  = 0
      end
      #start_time[day] = params[:chk_schedule][week_day[day]]
    end

    @lesson.warm_up = warm_up.to_json
    @lesson.conditioning = conditioning.to_json
    @lesson.start_time = start_time.to_json
    @lesson.end_time = end_time.to_json
    @lesson.events =events.to_json


    if @lesson.save
      redirect_to lessons_path
    else
      render action: :new
    end
  end

  def update
    @lesson = Lesson.find(params[:id])

    @lesson.schedule_repeat = params[:schedule_repeat]
    #create json format for hash
    warm_up = Hash.new
    warm_up[:equipment] =  params[:warmup_event]
    warm_up[:duration] = params[:warmup_duration]

    conditioning = Hash.new
    conditioning[:equipment] = params[:conditioning_event]
    conditioning[:duration]  = params[:conditioning_duration]

    events = Array.new
    for i  in 0...params[:events].length
      event_data = Hash.new
      event_data[:equipment] = params[:events][i]
      event_data[:min_use_duration] =params[:event_min_duration][i]
      event_data[:max_use_duration] =params[:event_max_duration][i]
      event_data[:total_use_duration] = params[:event_duration][i]
      events.push(event_data)
    end

    #start and end time

    start_time = Hash.new
    end_time = Hash.new


    week_day = ['mon','tue','wed','thu','fri','sat','sun']
    for day in 0..6

      if(params[:chk_schedule][week_day[day].to_sym].to_i==1)
        first_key = week_day[day]+'(4i)'
        second_key = week_day[day]+'(5i)'
        start_time[day]= params[:start_time][first_key].to_i* 60+ params[:start_time][second_key].to_i
        end_time[day]  = params[:end_time][first_key].to_i* 60+ params[:end_time][second_key].to_i
      else
        start_time[day]= 0
        end_time[day]  = 0
      end
      #start_time[day] = params[:chk_schedule][week_day[day]]
    end

    @lesson.warm_up = warm_up.to_json
    @lesson.conditioning = conditioning.to_json
    @lesson.start_time = start_time.to_json
    @lesson.end_time = end_time.to_json
    @lesson.events =events.to_json

    if @lesson.update_attributes(lesson_params)
      redirect_to lessons_path
    else
      render action: :edit
    end
  end

  def destroy
    Lesson.find(params[:id]).destroy
    redirect_to lessons_path
  end

  private
  def lesson_params
    params.require(:lesson).permit( :title, :user_id,  :instructor, :schedule_repeat, :warm_up, :conditioning, :start_time, :end_time,:events)
  end

  def get_json_variables
    #const durations
    @durations = Hash.new
    @durations[15] = "15 Minutes"
    @durations[30] = "30 Minutes"
    @durations[45] = "45 Minutes"
    @durations[60] = "60 Minutes"
    @durations[75] = "75 Minutes"
    @durations[90] = "90 Minutes"
    @durations[105] = "105 Minutes"
    @durations[120] = "120 Minutes"
    @durations[135] = "135 Minutes"
    @durations[150] = "150 Minutes"
    @durations[165] = "165 Minutes"
    @durations[180] = "180 Minutes"
    @durations[195] = "195 Minutes"
    @durations[210] = "210 Minutes"
    @durations[225] = "225 Minutes"

    #const timeline
    @times = Hash.new
    @times[15] = "15 Minutes"
    @times[30] = "30 Minutes"
    @times[45] = "45 Minutes"
    @times[60] = "60 Minutes"
    @times[75] = "75 Minutes"
    @times[90] = "90 Minutes"
    @times[105] = "105 Minutes"
    @times[120] = "120 Minutes"
    @times[135] = "135 Minutes"
    @times[150] = "150 Minutes"
    @times[165] = "165 Minutes"
    @times[180] = "180 Minutes"
    @times[195] = "195 Minutes"
    @times[210] = "210 Minutes"
    @times[225] = "225 Minutes"

    #schule repeat
    @repeat_interval = Hash.new
    @repeat_interval[1] = "Every Week"
    @repeat_interval[2] = "Every 2Weeks"

    #schedule_duration

    @schedule_duration = Hash.new
    @schedule_duration[12] = "12 Weeks"
    @schedule_duration[13] = "13 Weeks"
  end
end
