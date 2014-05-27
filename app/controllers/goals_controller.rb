class GoalsController < ApplicationController
	
  def index
		@goals = Goal.all
	end

  def new
    @goal = Goal.new
  end

  def create
    @goal= Goal.new(goal_params)
     if @goal.save
      redirect_to goals_path
    else
      flash[:error] = "Your Goal was not saved. Try again"
        redirect_to new_goals_path
    end 
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    @goal.update(goal_params)
    redirect_to goals_path
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to goals_path
  end

  private
    def goal_params
      params.require(:goal).permit(:name, :description)
    end

end
