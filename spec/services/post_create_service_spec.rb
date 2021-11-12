# frozen_string_literal: true

require 'spec_helper'

describe PostCreateService do
  subject { described_class.new(params).perform }

  describe '#perform' do
    context 'valid params' do
      let(:params) do
        post_params = FactoryBot.attributes_for(:post)
        user_params = FactoryBot.attributes_for(:user)
        post_params.merge user_params
      end

      it 'creates new post with user' do
        expect do
          subject
        end.to change { User.count }
          .by(1)
          .and change { Post.count }
          .by(1)
      end

      it 'returns attributes' do
        expect(subject.to_h.keys).to include(:post, :errors)
      end

      it 'returns empty errors' do
        expect(subject.errors).to eql([])
      end
    end

    context 'invalid user params' do
      let(:params) do
        post_params = FactoryBot.attributes_for(:post)
        user_params = FactoryBot.attributes_for(:user)
        user_params[:login] = ''
        post_params.merge user_params
      end

      it 'not creates any new records' do
        expect do
          subject
        end.to change { User.count }
          .by(0)
          .and change { Post.count }
          .by(0)
      end

      it 'returns proper validation error' do
        expect(subject.errors).to eql(["User creating error: Login can't be blank"])
      end

      it 'returns empty post object' do
        expect(subject.post).to be_nil
      end
    end

    context 'invalid post params' do
      let(:params) do
        post_params = FactoryBot.attributes_for(:post)
        user_params = FactoryBot.attributes_for(:user)
        post_params[:title] = ''
        post_params.merge user_params
      end

      it 'not creates any new records' do
        expect do
          subject
        end.to change { User.count }
          .by(0)
          .and change { Post.count }
          .by(0)
      end

      it 'returns proper validation error' do
        expect(subject.errors).to eql(["Post creating error: Title can't be blank"])
      end

      it 'returns empty post object' do
        expect(subject.post).to be_nil
      end
    end
  end
end
