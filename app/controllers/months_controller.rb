class MonthsController < ApplicationController

  before_action :load_master_goal, :load_date_info, :check_goal_owner

  def index
    # sql select all the sub-monthly-goals -> -> input that was previously typed in This months view
    @monthly_goals = @master_goal.months.where(year:@year)
    @months_array = [{month_name:'January', month_num: 1},
                     {month_name:'February', month_num: 2},
                     {month_name:'March', month_num: 3},
                     {month_name:'April', month_num: 4},
                     {month_name:'May', month_num: 5},
                     {month_name:'Jun', month_num: 6},
                     {month_name:'July', month_num: 7},
                     {month_name:'August', month_num: 8},
                     {month_name:'September', month_num: 9},
                     {month_name:'October', month_num: 10},
                     {month_name:'November', month_num: 11},
                     {month_name:'December', month_num: 12},]
  end

  def new
    @month_num = params["month_num"]
  end

  def create    
    @month_goal = @master_goal.months.new(month_num: params[:month_num], month_goal_name: params[:new_monthly_todo], year:@year)
    if @month_goal.save
      redirect_to goal_months_path(@master_goal,year:@year), notice: 'monthly goal was created'
    else
      render action: 'new'
    end
  end

  def edit
    @month_goal = Month.find(params[:id])
  end

  def update
    @month_goal = Month.find(params[:id])
    @month_goal.update(month_goal_params)
    redirect_to goal_months_path(@master_goal)
  end

  def destroy
    @month_goal = Month.find(params[:id])
    @month_goal.destroy
    redirect_to goal_months_path(@master_goal)
  end

  private

  def month_goal_params
    params.require(:month).permit(:month_goal_name, :year ,:month_num)
  end

  def load_master_goal
    @master_goal = Goal.find(params[:goal_id])
  end


  def load_date_info
    if params["year"] != nil
      @year = params["year"]
    else
      @year = Date.today.year
    end
  end

end
