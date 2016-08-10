require 'rails_helper'

RSpec.describe Report, type: :model do
		it 'belong to sender_user' do
	 		should belong_to(:sender_user)
		end

		it 'belong to reported_user' do
	 		should belong_to(:reported_user)
		end

		
	end
