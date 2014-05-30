require 'spec_helper'

describe Goal do
 it do
   g = Goal.reflect_on_association(:months)
   g.macro.should === :has_many
  end

 # it { should have_many(:weeks) }
 # it { should have_many(:days) }
end
