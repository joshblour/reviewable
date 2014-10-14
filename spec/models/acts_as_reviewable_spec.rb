require 'rails_helper'

module Reviewable
  RSpec.describe Product, :type => :model do
    
    it { should have_many(:reviews) }
    it { should have_many(:reviewers).through(:reviews) }
    it { should accept_nested_attributes_for(:reviews) }
    
    
  end
end
