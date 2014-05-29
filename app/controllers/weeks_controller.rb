class WeeksController < ApplicationController
  before_action :load_master_goal, :load_date_info

  def index
    @given_month_sub_goals = Month.where(goal_id:params[:goal_id], month_num:params[:month_id], year:params[:year])
    @weekly_goals = Week.where(goal_id:params[:goal_id], month:params[:month_id], year:params[:year])
    # TODO should be an array of hashes with 2values: [week_num: 1-52 , week_dates:week dates for given week] for given Year!!
    @weeks_array = []
    month_begining_day = Date.new(@year.to_i, @month.to_i, 1)
    month_ending_day = month_begining_day.at_end_of_month
    month_begining_week = month_begining_day.strftime("%V").to_i
    month_ending_week = month_ending_day.strftime("%V").to_i
    week_begining_day = month_begining_day.beginning_of_week
    week_ending_day = week_begining_day.end_of_week
    for i in month_begining_week .. month_ending_week do
        @weeks_array.push({week_num: i, week_dates:"#{Date::MONTHNAMES[week_begining_day.month]}#{week_begining_day.day}-#{Date::MONTHNAMES[week_ending_day.month]}#{week_ending_day.day}"})
        week_begining_day += 7
        week_ending_day += 7
    end
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

  # def edit
  #   @new_week_goal = New_week_goal.find(params[:id])
  # end

  # def update
  #   @new_week_goal = New_week_goal.find(params[:id])
  #   @new_week_goal.update(goal_params)
  #   redirect_to new_goal_month_week
  # end

  # def destroy
  #   @new_week_goal = New_week_goal.find(params[:id])
  #   @new_week_goal.destroy
  #   redirect_to  goal_month_week_path
  # end

  private
    def goal_params
      params.require(:goal).permit(:name, :description)
    end

  private

  def load_master_goal
    @master_goal = Goal.find(params[:goal_id])
  end

  def load_date_info
    # TODO: make sure that year, month are hard coded into the website and user can change that
    # (so that it's not taken from params only since they can be deleted)
    @month = params[:month_id]
    @year = params[:year]
  end

  end
