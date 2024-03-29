require 'spec_helper'

describe User do
	before(:each) do
		@attr = {:name => "Example user", 
				 :email=> "user@example.com",
				 :password => "foobar",
				 :password_confirmation => "foobar"
			 }
	end
  it "should create a new instance of valid attribute" do
  	 User.create!(@attr)
  end
  it "should have a name " do 
  	no_name_user  = User.new(@attr.merge(:name => ""))
  	no_name_user.should_not be_valid
  end
  it "should have a email " do 
  	no_email_user  = User.new(@attr.merge(:email => ""))
  	no_email_user.should_not be_valid
  end
  it "should reject names too long" do
  	long_name = "a" *51
  	long_name_user = User.new(@attr.merge(:name => long_name))
  	long_name_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
  	addresses = %w[user@info.com THE_USER@foo.bar.com first.last@foo.jp]
  	addresses.each do  |address|
  		valid_email_user = User.new(@attr.merge(:email => address))
  		valid_email_user.should be_valid  		
  	 end
  end
  it "should reject invalid email addresses" do
  	addresses = %w[user@info,com user_at_foo.org example.user@foo.]
  	addresses.each do  |address|
  		invalid_email_user = User.new(@attr.merge(:email => address))
  		invalid_email_user.should_not be_valid  		
  	 end
  end
  
  it "should reject duplicate email ids " do 
  	  User.create!(@attr)
  	  user_with_duplicate_email = User.new(@attr)
  	  user_with_duplicate_email.should_not be_valid
  	end
  	
  it "should reject email id up to case" do 
  	  upcased_email = @attr[:email].upcase
  	  User.create!(@attr.merge(:email => upcased_email))
  	  user_with_duplicate_email = User.new(@attr)
  	  user_with_duplicate_email.should_not be_valid
  	end
  describe "passwords"	do
  	 	before(:each) do
  	 	@user = User.new(@attr)
  	 	end
  	it "should have password attributes" do
  	  	  @user.should respond_to(:password)
   	end
  	it "should have password confirmation attributes" do
  			  @user.should respond_to(:password_confirmation)
  	end
  end
  describe "password validations" do
  	it "should require a password" do
  		User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
  	 end
  	it "should require a matching password confirmation" do
  		User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
  	 end
  	it "should reject short password" do
  		short = "a" * 5
  		hash = @attr.merge(:password => short , :password_confirmation => short)
  		User.new(hash).should_not be_valid
  	 end
  	 it "should reject long password" do
  		long = "a" * 41
  		hash = @attr.merge(:password => long , :password_confirmation => long)
  		User.new(hash).should_not be_valid
  	 end
  end
  describe "password encryption" do
  	before(:each) do
  	 @user = User.create!(@attr)
  	end
  	it "should have an encrypted password field" do
  		@user.should respond_to(:encrypted_password)
  	end
  	it "should have a salt" do
  		@user.should respond_to(:salt)
  	end
  	it "Should set the encrypted password attribute" do
  		@user.encrypted_password.should_not be_blank
  	end
  	 describe "has_password? method" do
  		 it "should exist" do
  	 		@user.should respond_to(:has_password?)
  		 end
  		 it "should return true if password match" do
  		 	@user.has_password?(@attr[:password]).should be_true
		 end  		
  		 it "should return false if passwords do not match" do
  		 	@user.has_password?("invalid").should be_false
  		 end  		 
     end
     describe "authenticate method" do
     	it "should exist " do
     		User.should respond_to(:authenticate)
 	    end
 	    it "should return nil on user/email mismatch" do
 	    	User.authenticate(@attr[:email],"bargoo").should be_nil
 	    end
 	    it "should return nil on email with no user" do
 	    	User.authenticate("bar@foo.org",@attr[:password]).should be_nil
 	    end
 	    it "should return the user on email/password match" do
 	    	User.authenticate(@attr[:email],@attr[:password]).should == @user
 	    end
     end
  end
 
end 
# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  encrypted_password :string(255)
#  salt               :string(255)
#

