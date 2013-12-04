
require 'spec_helper'

describe Link do
  
  before do
    @link = build :link
  end
  
  it 'should be valid with factory link' do 
    @link.should be_valid
  end
  
  describe 'url' do
    
    it 'should require a url' do
      @link.url = nil
      @link.should_not be_valid
    end
    
  end
  
  describe 'should require a name' do
    it 'should require a name' do
      @link.name = nil
      @link.should_not be_valid
    end
  end
  
end
