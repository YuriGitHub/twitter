require 'rails_helper'
	RSpec.describe User, type: :model do
		it 'have many User reports' do
	 		should have_many(:user_reports)
		end

		it 'have many User reports on user' do
	 		should have_many(:reports_on_user)
		end

		it 'Naby posts' do
	 		should have_many(:posts)
		end
	end
