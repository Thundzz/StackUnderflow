require 'spec_helper'

describe Tag do
  	before {
  		@tag = Tag.new(name: "Test", description: "This tag deals with tests")
	}
	subject { @tag }

	it { should respond_to(:name) }
	it { should respond_to(:description) }

	it { should be_valid }

    describe "when name is not present" do
      before { @tag.name = ""}
      it { should_not be_valid }
    end

	describe "when name is too long" do
      before { @tag.name = "a"*151 }
      it { should_not be_valid }
    end

    describe "when someone searches for the tag" do
    	before { @tag_found = Tag.search("Test") }
    	@tag_found.should == @tag
    end
end
