require 'spec_helper'

describe User do
  describe "with CAS" do
    before {
      @user = User.new(login: "twinki")
    }
    subject { @user }

    it {should be_valid }

    describe "when login is not present" do
      before { @user.login = "" }
      it { should_not be_valid }
    end
  end

  describe "with full information" do
    before {
    	@user = User.new(login: "twinki", name: "Tinki", lastname: "Winki", email: "example@test.com", right: User::USER, study: User::ELEC, password: "greatpass", password_confirmation: "greatpass")
    }
    subject { @user }

    it { should respond_to(:login) }
    it { should respond_to(:name) }
    it { should respond_to(:lastname) }
    it { should respond_to(:email) }
    it { should respond_to(:right) }
    it { should respond_to(:study) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }
    it { should respond_to(:badges) }

    it { should be_valid }


    describe "when login is not present" do
      before { @user.login = ""}
      it { should_not be_valid }
    end

    describe "when login is too long" do
      before { @user.login = "a"*51 }
      it { should_not be_valid }
    end

    describe "when name is too long" do
    	before { @user.name = "a"*51 }
    	it { should_not be_valid }
    end

    describe "when lastname is too long" do
    	before { @user.lastname = "a"*51 }
    	it { should_not be_valid }
    end

    describe "when email format is invalid" do
    	it "should be invalid" do
    		addresses = %w[user@foo,com user_at_foo.org user.foo.com hello@foo@orange.fr love@me+you.com]
    		addresses.each do |invalid_address|
    			@user.email = invalid_address
    			expect(@user).not_to be_valid
    		end
    	end
    end

    describe "when email format is valid" do
    	it "should be valid" do
    		addresses = %w[user@foo.com ComeOn@user.com hello@orange.fr me+you@yopmail.com]
    		addresses.each do |valid_address|
    			@user.email = valid_address
    			expect(@user).to be_valid
    		end
    	end
    end

    describe "when email address is already taken" do
      before do
        user_with_same_email = @user.dup
        user_with_same_email.email = @user.email.upcase
        user_with_same_email.save
      end

      it { should_not be_valid }
    end

    describe "when password doesn't match confirmation" do
    	before do
    		@user.password_confirmation = "badpass"
    	end
    	it {should_not be_valid}
    end

    describe "with a password which is too short" do
      before { @user.password = @user.password_confirmation = "a"*5 }
      it {should_not be_valid}
    end

    describe "with a password which is too long" do
      before { @user.password = @user.password_confirmation = "a"*41 }
      it {should_not be_valid}
    end

    describe "return value of authenticate method" do
    	before {@user.save}
    	let(:found_user) {User.find_by_login(@user.login)}

    	describe "with valid password" do
    		it {should == User.authenticate(found_user.login, @user.password)}
    	end

    	describe "with invalid password" do
    		let(:user_for_invalid_pass) {User.authenticate(found_user.login, "invalidpass")}
    		it {should_not == user_for_invalid_pass}
    		specify {expect(user_for_invalid_pass).to be_false}
    	end
    end
  end
end
