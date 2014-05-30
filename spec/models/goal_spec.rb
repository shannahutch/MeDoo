require 'spec_helper'

describe Goal do
  #testing associations
  it do
    g = Goal.reflect_on_association(:months)
    g.macro.should === :has_many
  end
  it do 
    g = Goal.reflect_on_association(:weeks)
    g.macro.should === :has_many
  end
  it do
    g = Goal.reflect_on_association(:days)
    g.macro.should === :has_many 
  end
  describe 'a new goal' do
    it 'can be created'do
      @goal = Goal.create(name: "max", description: "get there this year")

      Goal.where(name: "max").first.should_not == nil
# testing methods  to see that they work not content
      @goal.should respond_to :description
      @goal.should respond_to :name
#testing for content
      @goal.name.should == "max"
      @goal.description.should == "get there this year"
    end
    it 'can be destroyed' do
       @goal2 = Goal.create(name: "max", description: "get there this year")
       @goal2.destroy
       #Goal.where(name: "max").first.destroy

       @goal2.should_not == nil
    end
  end
end
