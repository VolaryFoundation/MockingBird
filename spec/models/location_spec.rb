
require 'spec_helper'

describe Location do
  
  before do
    @location = build :location
  end
  
  it 'should be valid with factory location' do 
    @location.should be_valid
  end
  
  describe 'lng_lat' do
    
    it 'should require lng_lat' do
      @location.lng_lat = nil
      @location.should_not be_valid
    end
    
  end
  
  describe 'country' do
    it 'should require country' do
      @location.country = nil
      @location.should_not be_valid
    end
  end
  
  describe 'state' do
    it 'should require state if there is a city' do
      @location.state = nil
      @location.should_not be_valid
    end
    
    it 'should not require state if there is not a city' do
      @location.state = nil
      @location.city = nil
      @location.address = nil
      @location.should be_valid
      
    end
  end
  
  describe 'city' do
    it 'should require city if an address' do
      @location.city = nil
      @location.should_not be_valid
    end
    
    it 'should not require city if there is not an address' do
      @location.city = nil
      @location.address = nil
      @location.should be_valid
    end
  end
  
  describe 'postal code' do
    it 'should require a postal code if there is an address' do
      @location.postal_code = nil
      @location.should_not be_valid
    end
    
    it 'should not require postal code if there is not an address' do
      @location.postal_code = nil
      @location.address = nil
      @location.should be_valid
    end
  end
  


end
