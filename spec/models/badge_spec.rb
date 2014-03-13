require 'spec_helper'

describe Badge do
	before {
  		@badge = Badge.initialize("test_badge", "Meilleur testeur de badge", "Avoir testé le modèle des badges", :gold)
	}
	subject { @badge }

	it { should respond_to(:name) }
	it { should respond_to(:official_name) }
	it { should respond_to(:description) }
	it { should respond_to(:metal) }

	it { should be_valid }

    describe "when name is not present" do
      before { @badge.name = ""}
      it { should_not be_valid }
    end

    describe "when official_name is not present" do
      before { @badge.official_name = ""}
      it { should_not be_valid }
    end

    describe "when name is already taken" do
      let(:badge_with_same_name) { @badge.dup }
      it { badge_with_same_name.should_not be_valid }
    end
end
