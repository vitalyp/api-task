# frozen_string_literal: true

require 'spec_helper'

describe User, type: :model do
  it 'has valid factory' do
    expect(build(:user)).to be_valid
  end

  it 'is invalid without login' do
    expect(build(:user, login: nil)).to be_invalid
  end

  it 'has unique login' do
    user1 = create(:user)
    user2 = build(:user, login: user1.login)
    user2.save

    expect(user2.errors.full_messages.first).to eq('Login has already been taken')
  end

  it 'has posts' do
    assoc = described_class.reflect_on_association(:posts)
    expect(assoc.macro).to eq(:has_many)
  end

  it 'has ratings' do
    assoc = described_class.reflect_on_association(:ratings)
    expect(assoc.macro).to eq(:has_many)
  end
end
