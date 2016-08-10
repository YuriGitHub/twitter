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
                it 'checks login uniqueness and presence validator' do
                    validate_presence_of :login
                    validate_uniqueness_of :login
                end
                it 'checks date of birth validator' do
                    u1 = User.new(login:'somel1',date_of_birth:201.years.ago.to_date)
                    u2 = User.new(login:'somel2',date_of_birth:82.years.ago.to_date)
                    u3 = User.new(login:'somel3',date_of_birth:17.years.ago.to_date)
                    u4 = User.new(login:'somel4',date_of_birth:15.years.ago.to_date)
                    u1.save
                    u2.save
                    u3.save
                    u4.save
                    expect(u1.valid?).to be false
                    expect(u2.valid?).to be true
                    expect(u3.valid?).to be true
                    expect(u4.valid?).to be false
                    expect(u4.valid?).to be false
	        end
        end
