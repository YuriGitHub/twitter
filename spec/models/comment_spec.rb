require 'rails_helper'
RSpec.describe Comment, type: :model do

    it 'checks relations' do
        should belong_to :post
    end


end
