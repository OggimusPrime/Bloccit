require 'rails_helper'

include TestFactories

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

  describe 'after_save' do
    it "calls 'Post#update_rank' after save" do
      post = associated_post
      vote = Vote.new(value: 1, post: post)
      expect(post).to receive(:update_rank)
      vote.save
    end
  end
end
