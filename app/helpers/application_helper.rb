module ApplicationHelper
  def check_goal_owner
    master_goal = current_user.goals.find_by(id:params[:goal_id])
    if master_goal.nil?
      flash[:error] = "That's not your goal."
      redirect_to root_path
    end
  end
end
