require 'rails_helper'


RSpec.describe Comment, type: :model do
  it 'test for post ' do
 should belong_to(:post)
end
end
