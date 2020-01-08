require 'rails_helper'

RSpec.describe User, type: :model do

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  
  describe 'uniqueness' do  
    # let(:user) { user = User.create(
    #         username: 'joe',
    #         password: 'hunter2'
    #     )
    # }


    before(:each) do
        user = User.create(
            username: 'joe',
            password: 'hunter2'
            # password_digest: 'asdfasdfasdf',
            # session_token: 'alskdfjwelij'
        )
    end
    
    it { should validate_uniqueness_of(:username) }
  end
  
  describe 'session token' do
    # let(:user) { user = User.create(
    #         username: 'joe',
    #         password: 'hunter2'
    #     )
    # }

    before(:each) do
        User.create(
            username: 'joe',
            password: 'hunter2',
        )

      end
      
      # user = User.create(
        #     username: 'joe',
        #     password: 'hunter2'
        # )
      it 'always has a value' do
        user = User.find_by(username: 'joe')
        expect(user.session_token).not_to be_empty
    end

    it 'creates and saves new session token for user' do 
        user = User.find_by(username: 'joe')
        old_token = user.session_token
        user.reset_session_token!
      expect(old_token).not_to eq(user.session_token)
    end
  end
  
  describe 'takes in password and creates password_digest' do
    before(:each) do
        User.create(
            username: 'joe',
            password: 'hunter2',
        )
      end
      
      it 'doesn\'t save plain text password' do
        user = User.find_by(username: 'joe')
        expect(user.password).not_to be('hunter2')
      end

      it 'takes password_digest and returns true for correct password' do
        user = User.find_by(username: 'joe')
        expect(user.is_password?('hunter2')).to be(true)
      end

      it 'takes password_digest and returns false for wrong password' do
        user = User.find_by(username: 'joe')
        expect(user.is_password?('hunter3')).to be(false)
      end
  end

  describe 'find by credentials' do
    it 'finds user with given username and password' do
      user = User.create(
            username: 'joenewagain',
            password: 'hunter2'
        )

      expect(User.find_by_credentials('joenewagain', 'hunter2')).to eq(user)
    end
  end
end
