require 'rails_helper'

RSpec.describe Article, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
  it { should validate_presence_of :body }
  it { should have_one_attached(:image) }
  it { should define_enum_for(:state).with(draft: 0, published: 1) }
end
