class WeeksController < ApplicationController
  before_action :load_master_goal, :load_date_info

  def index
    # sql select all the sub-monthly-goals -> input from the monthly view
    @given_month_sub_goals = @master_goal.months.where(month_num:@month, year:@year)

    # sql select all the sub-weekly-goals -> input that was previously typed in This weekly view
    @month_week_goals = load_month_week_goals(@master_goal, @year, @month)

    # Creating the "framework" for displaying the @weekly_goals on page (sections' descriptions + week_num provided)
    @weeks_array = create_weeks_array(@year, @month)

    # Creating variables for < > selection of the month, making sure that there is 1 after 12
    @next_month = next_month(@month)
    @previous_month = previous_month(@month)
  end

  def new
    @week_num = params["week_num"]
    # binding.pry
  end

  def create
    @new_week_goal = @master_goal.weeks.new(year: params[:year], week_num: params[:week_num], weekly_goal_name: params[:new_weekly_todo])
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
    if params["month_id"] != nil
      @month = params["month_id"].to_i
    else
      @month = Date.today.month
    end

    if params["year"] != nil
      @year = params["year"].to_i
    else
      @year = Date.today.year
    end
  end

  def previous_month(month)
     if month-1 > 0
      previous_month = month-1
    else
      previous_month = 12
    end
    
  end

  def next_month(month)
    if month+1 < 13
      next_month = month+1
    else
      next_month = 1
    end
  end

  def create_weeks_array(year, month)
    weeks_array = []
    month_begining_day = Date.new(year, month, 1)
    month_ending_day = month_begining_day.at_end_of_month
    month_begining_week = month_begining_day.strftime("%V").to_i
    month_ending_week = month_ending_day.strftime("%V").to_i
    week_begining_day = month_begining_day.beginning_of_week
    week_ending_day = week_begining_day.end_of_week
    week = month_begining_week
    until week == month_ending_week
      weeks_array.push({year:year, month:month, week_num: week, week_dates:"#{Date::MONTHNAMES[week_begining_day.month]}#{week_begining_day.day}-#{Date::MONTHNAMES[week_ending_day.month]}#{week_ending_day.day}"})
      week_begining_day += 7
      week_ending_day += 7
      week = week_begining_day.strftime("%V").to_i
    end

    if month_ending_week>month_begining_week
      weeks_array.push({year:year, month:month,  week_num: week, week_dates:"#{Date::MONTHNAMES[week_begining_day.month]}#{week_begining_day.day}-#{Date::MONTHNAMES[week_ending_day.month]}#{week_ending_day.day}"})
    else
      weeks_array.push({year:(year.to_i+1), month:1, week_num: week, week_dates:"#{Date::MONTHNAMES[week_begining_day.month]}#{week_begining_day.day}-#{Date::MONTHNAMES[week_ending_day.month]}#{week_ending_day.day}"})    
    end
    return weeks_array
  end

  # Selecting only the week_num(s) that belong to given month. 
  def load_month_week_goals(master_goal, year, month)  
    week_array = create_weeks_array(year,month)
    if week_array.first[:week_num]<week_array.last[:week_num]
      month_week_goals = master_goal.weeks.where(week_num:week_array.first[:week_num]..week_array.last[:week_num], year:year)
    else
      # Resolving also potential Dec issue where last week is #1
      month_week_goals = master_goal.weeks.where( '(week_num >= ? AND year = ?) OR (week_num = 1 AND year = ? )', week_array.first[:week_num], year, year+1 )
    end
    return month_week_goals
  end
end
