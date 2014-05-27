class MonthsController < ApplicationController

  before_action :load_action


  def index
    @months = @goal.months.all
  end

  def new
    @month = @goal.months.new
  end

  def create
    @month = @goal.months.new(month_params)
      if @month.save
        redirect_to [@goal, @month], notice: 'Goal was created'
      else
        render action: 'new'
      end
  end

  def show
  end


private

  def month_params
    params.require(:month).permit(:month_name, :month_goal_1, :month_goal_2, :month_goal_3)
  end

  def load_action
    @goal = Goal.find(params[:goal_id])
  end

end
