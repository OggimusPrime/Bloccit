require 'rails_helper'

describe Vote do 
  describe "validations" do
    describe "value validation" do
      it "only allows -1 or 1 as values" do
        
        valid_vote = Vote.new(value: 1)
        expect(valid_vote.valid?).to eq(true)

        valid_vote2 = Vote.new(value: -1)
        expect(valid_vote2.valid?).to eq(true)

        invalid_vote = Vote.new(value: 2)
        expect(invalid_vote.valid?).to eq(false)
      end
    end
  end
end
