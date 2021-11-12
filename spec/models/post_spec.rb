# frozen_string_literal: true

require 'spec_helper'

describe Post, type: :model do
  it 'has valid factory' do
    expect(build(:post, user: build(:user))).to be_valid
  end

  it 'is invalid without title' do
    expect(build(:post, title: nil)).to be_invalid
  end

  it 'belongs to user' do
    assoc = described_class.reflect_on_association(:user)
    expect(assoc.macro).to eq(:belongs_to)
  end

  it 'has ratings' do
    assoc = described_class.reflect_on_association(:ratings)
    expect(assoc.macro).to eq(:has_many)
  end
end
