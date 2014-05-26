class GoalsController < ApplicationController
	def index
		@goals = Goal.all
	end


  def new
    @goal = Goal.new

    # redirect_to new_goals_path
  end

  def create
    #binding.pry
    goal_params = params.require(:goal).permit(:name, :description)
    new_goal = Goal.new(goal_params)
    # if new_goal.save
    #   redirect_to new_goals_path
    # else
    #   flash[:error] = "Your Goal was not saved. Try again"
    #     redirect_to new_goals_path
    # end
      
  end



  # private
  #   def goal_params
  #     params.require(:goal).permit(:name, :description)
  #   end
# new_page
end
