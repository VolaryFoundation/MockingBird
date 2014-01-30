require 'spec_helper'

describe User do
  
  before do
    @user = build :user
  end
  
  describe 'basic object' do
    
    it "should be valid with facotry user" do
      @user.should be_valid
    end

    it 'should require an email' do
      @user.email = nil
      @user.should_not be_valid
    end
    
    it 'should require a password' do
      @user.password = nil
      @user.should_not be_valid
    end
  end
  
  describe 'authization' do
    
    it "should be able to encrypt the password" do
      @user.password_hash.should be_nil
      @user.encrypt_password
      @user.password_hash.should_not be_nil
    end

    it 'should authorize a user with correct credintials' do
      @user.save
      test = User.authenticate(@user.email, '!QAZxsw2')
      test.should eq(@user)
    end
    
    it 'should return nill if credentials are wrong' do
      @user.save
      test = User.authenticate('Random', 'Random')
      test.should be_nil
    end
  end

end
