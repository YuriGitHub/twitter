require 'rails_helper'
RSpec.describe Comment, type: :model do
<<<<<<< HEAD
    it 'checks relations' do
        should belong_to :post
    end
=======
  it 'test for post ' do
 should belong_to(:post)
end
>>>>>>> d42db668f20f11074786cc0a599c317414bc0b58
end
