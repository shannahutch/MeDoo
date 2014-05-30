require 'spec_helper'

describe Goal do
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
  
end
