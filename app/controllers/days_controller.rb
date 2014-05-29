class DaysController < ApplicationController
	  before_action :load_master_goal, :load_date_info

  def index
    @given_week_sub_goals = @master_goal.weeks.where(week_num:@week, year:@year)
    @day_tasks = @master_goal.days.where(week_num:@week, year:@year)
    # TODO should be an array of hashes with 2values: [day_num: 1-31 , day_dates:full day name for given day] for given week!!
    @days_array = []
    for i in 1..7 do
    	@days_array.push({day_name: Date::DAYNAMES[Date.commercial(@year.to_i,@week.to_i,i).wday], date: Date.commercial(@year.to_i,@week.to_i,i)})
    end
    # binding.pry
  end

  def new
    @week_num = params["week_num"]
  end

  def create
    @new_week_goal = @master_goal.weeks.new(year: params[:year], month: params[:month_id], week_num: params[:week_num], weekly_goal_name: params[:new_weekly_todo])
    if @new_week_goal.save
      redirect_to goal_month_weeks_path(@master_goal,@month,year:params[:year]), notice: 'Weekly goal was created'
    else
      render action: 'new'
    end
  end

  def show
  end


  private

  def load_master_goal
    @master_goal = Goal.find(params[:goal_id])
  end

  def load_date_info
    # TODO: make sure that year, month are hard coded into the website and user can change that
    # (so that it's not taken from params only since they can be deleted)
    @week = params[:week_id]
    @month = params[:month_id]
    @year = params[:year]
  end
end
