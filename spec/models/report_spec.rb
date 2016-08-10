require 'rails_helper'

RSpec.describe Report, type: :model do
		it 'belong to sender_user' do
	 		should belong_to(:sender_user)
		end

		it 'belong to reported_user' do
	 		should belong_to(:reportable)
		end

		describe 'Validation test' do

			it 'validate text length' do
				should validate_length_of(:report_text).is_at_least(30).is_at_most(300)
			end
			it 'validate presence report text' do
				should validate_presence_of :report_text
			end

		end
	end
