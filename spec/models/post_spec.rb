require 'rails_helper'

RSpec.describe Post, type: :model do
    it 'checks relations' do
        should belong_to :user
        should have_many :likes
        should have_many :images
        should have_many :comments
    end
end
