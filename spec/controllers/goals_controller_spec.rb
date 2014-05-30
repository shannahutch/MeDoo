require 'spec_helper'

describe GoalsController do
  describe "GET index" do
    it "assigns @goals" do
      goal = Goal.create
      get :index
      expect(assigns(:teams)).to eq([goal])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
  
end
