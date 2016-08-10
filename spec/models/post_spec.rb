require 'rails_helper'

RSpec.describe Post, type: :model do
    it 'checks relations' do
        should belong_to :user
        should have_many :likes
        should have_many :images
        should have_many :comments
    end
# validates :text, length: { in: 10...140}
# 	validates :text, :user_id, presence: true
    describe 'Testing validateion' do 
    		it 'checking validation text length' do
    			should validate_length_of(:text).is_at_most(139).is_at_least(10)
    		end

    		it 'Testing presence of fields' do
    			should validate_presence_of(:text)
    			should validate_presence_of(:user_id)
    		end
    end
end
