require 'spec_helper'

describe Question do
  	before {
  		user = User.new(login: "twinki", name: "Tinki", lastname: "Winki", email: "example@test.com", right: User::USER, study: User::ELEC, password: "greatpass", password_confirmation: "greatpass")
		@question = Question.new(title: "What question do you want to ask?", content: "I'm a great question, aren't I?", user: user)
	}
	subject { @question }

	it { should respond_to(:title) }
	it { should respond_to(:content) }
	it { should respond_to(:user) }
	it { should respond_to(:score) }
	it { should respond_to(:views) }
	it { should respond_to(:tag_tokens) }

	it { should be_valid }

	describe "when title is not present" do
      before { @question.title = ""}
      it { should_not be_valid }
    end

    describe "when content is not present" do
      before { @question.content = ""}
      it { should_not be_valid }
    end

    describe "when user is not present" do
      before { @question.user = nil}
      it { should_not be_valid }
    end

	describe "when title is too long" do
      before { @question.title = "a"*501 }
      it { should_not be_valid }
    end

    describe "when someone searches for the question" do
    	before { @question_found = Question.search("What question do you want to ask?") }
    	@question_found.should == @question
    end
end
