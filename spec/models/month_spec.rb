require 'spec_helper'

describe Month do
  it do
    m = Month.reflect_on_association(:goal)
    m.macro.should === :belongs_to
  end
  it do
    m = Month.reflect_on_association(:weeks)
    m.macro.should === :has_many
  end
end
