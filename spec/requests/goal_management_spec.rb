require 'spec_helper'

describe 'Goals Management' do
  describe '/goals' do
    it 'displays an index of goals' do
      get '/goals' 
      response.status.should == 200
      response.should render_template :index

    end
    xit 'can be destroyed' do
     
    end
    xit 'can be creates' do
    end
  end
end
