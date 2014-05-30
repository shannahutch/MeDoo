require 'spec_helper'

describe Day do
  it do
    d = Day.reflect_on_association(:goal)
    d.macro.should === :belongs_to
  end
end
