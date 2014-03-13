require 'spec_helper'

describe Answer do
 	before {
  		user = User.new(login: "twinki", name: "Tinki", lastname: "Winki", email: "example@test.com", right: User::USER, study: User::ELEC, password: "greatpass", password_confirmation: "greatpass")
		question = Question.new(title: "What question do you want to ask?", content: "I'm a great question, aren't I?", user: user)
		@answer = Answer.new(content: "I'm the best answer in the world.", user: user, question: question)
	}
	subject { @answer }

	it { should respond_to(:content) }
	it { should respond_to(:user) }
	it { should respond_to(:question) }
	it { should respond_to(:validated) }

	it { should be_valid }

    describe "when content is not present" do
      before { @answer.content = ""}
      it { should_not be_valid }
    end

    describe "when user is not present" do
      before { @answer.user = nil}
      it { should_not be_valid }
    end

    describe "when question is not present" do
      before { @answer.question = nil}
      it { should_not be_valid }
    end

    describe "when the asker validates the answer" do
    	before { @answer.validate }
    	it { @answer.validated == true }
    end
end
