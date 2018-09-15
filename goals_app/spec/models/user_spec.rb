require 'rails_helper'

RSpec.describe User, type: :model do
  let(:john) { User.create!(username: 'john', email: 'john@john.com', password: 'starwars') }
  
  it { should validate_presence_of(:username)}
  it { should validate_presence_of(:session_token)}
  it { should validate_length_of(:password).is_at_least(6) }

  
    describe '::find_by_credentials' do 
      # let(:user) { User.create!(username: 'dacy', email:'dacy@dacy.com', password:'starwars') }
      
      it 'finds the correct user ' do
        user = User.create!(username: 'dacy', email:'dacy@dacy.com', password:'starwars')
        expect(User.find_by_credentials('dacy','starwars')).to eq(user)
      end
    end
    
  
end
