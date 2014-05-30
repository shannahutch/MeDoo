class DaysController < ApplicationController
	  before_action :load_master_goal, :load_date_info

  def index
    
    # sql select all the sub-weekly-goals -> input from the weekly view
    @given_week_sub_goals = @master_goal.weeks.where(week_num:@week, year:@year)

    # sql select all the daily tasks for give week -> input that was previously typed in This day view
    @week_day_tasks = @master_goal.days.where(week_num:@week, year:@year)

    # Creating the "framework" for displaying the @week_day_tasks on page (day_name + date provided)
    @days_array = []
    for i in 1..7 do
    	@days_array.push({day_name: Date::DAYNAMES[Date.commercial(@year,@week,i).wday], date: Date.commercial(@year,@week,i)})
    end

    # Creating variables for < > selection of the week, making sure that there is 1 last week of given year
    @next_week = next_week(@week, @year)
    @previous_week = previous_week(@week, @year)
  end

  def new
  	@day = params[:day]
  end

  def create
	  @day = params[:day].to_i
    @new_day_task = @master_goal.days.new(year: @year, month: @month, week_num: Date.new(@year,@month,@day).strftime("%V").to_i, day:@day, day_task_name: params[:new_day_task])
    if @new_day_task.save
      redirect_to goal_days_path(@master_goal,week:@week,year:params[:year]), notice: 'Day Task was created'
    else
      render action: 'new'
    end
  end

  def edit
    @task = Day.find(params[:id])    
  end

  def update
    @task = Day.find(params[:id])
    @task.update(task_params)
    @task.update(week_num:(Date.new(@task[:year],@task[:month],@task[:day]).strftime("%V").to_i))
    redirect_to goal_days_path(@master_goal,week:@week)
  end

  def destroy
    @task = Day.find(params[:id])
    @task.destroy
    redirect_to goal_days_path(@master_goal,week:@week)
  end


  private
  def task_params
    params.require(:day).permit(:day_task_name, :day, :month, :year)
  end

  def load_master_goal
    @master_goal = Goal.find(params[:goal_id])
  end

  def load_date_info

    if params["year"] != nil
      @year = params["year"].to_i
    else
      @year = Date.today.year
    end  

    # handling special case when somebody changes the year in daily view on week 53 and another year has only 52wks
    if params["week"].to_i <= last_year_week_num(@year)
      if params["week"] != nil
        @week = params[:week].to_i
      else
        @week = Date.today.strftime("%V").to_i
      end
    else
      @week = last_year_week_num(@year)
    end

    @month = Date.commercial(@year,@week,4).month

  end

  def last_year_week_num(year)
    last_year_day = Date.new(year,12,31)
    if last_year_day.strftime("%V").to_i != 1
      return last_year_day.strftime("%V").to_i
    else
      return (last_year_day-7.days).strftime("%V").to_i
    end
  end

  def next_week(current_week,year)
    if current_week+1 <= last_year_week_num(year)
      return current_week+1
    else
      return 1
    end
  end

  def previous_week(current_week,year)
    if current_week-1 >= 1 
      return current_week-1
    else
      return last_year_week_num(year)
    end
  end
end
