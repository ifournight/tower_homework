require 'rails_helper'

RSpec.describe SessionsHelper, '#sign_in' do
  it "store user's id in session[:user_id]" do
    user = build(:user)

    sign_in(user)

    expect(session[:user_id]).to eq user.id
  end
end

RSpec.describe SessionsHelper, '#signed_in?' do
  context 'when current is nil' do
    it 'return false' do
      allow(self).to receive(:current_user).and_return(nil)

      expect(signed_in?).to eq false
    end
  end

  context 'when current is not nil' do
    it 'return true' do
      user = build(:user)
      allow(self).to receive(:current_user).and_return(user)

      expect(signed_in?).to eq true
    end
  end
end

RSpec.describe SessionsHelper, '#current_user' do
  context 'when session[:user_id] = nil' do
    it 'return nil' do
      session[:user_id] = nil

      expect(current_user).to eq nil
    end
  end

  context 'when session[:user_id] = invalid user id' do
    it 'return nil' do
      session[:user_id] = -9999

      expect(current_user).to eq nil
    end
  end

  context 'when session[:user_id] = valid user id' do
    it 'return this user' do
      user = create(:user)
      session[:user_id] = user.id

      expect(current_user.id).to eq user.id
    end
  end
end
