require 'spec_helper'

describe Week do
  it do
    w = Week.reflect_on_association(:goals)
    w.macro.should === :belongs_to
  end
end
