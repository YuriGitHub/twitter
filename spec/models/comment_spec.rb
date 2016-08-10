require 'rails_helper'
RSpec.describe Comment, type: :model do

    it 'checks relations' do
        should belong_to :post
    end
    it 'check validations' do
     	should validate_presence_of :text
     	should validate_presence_of :user_id
     	should validate_presence_of :post_id 
     	should validate_length_of(:text).is_at_most(50)
    end


end
