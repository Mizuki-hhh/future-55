require 'rails_helper'
describe Content do
  before do
    @content = FactoryBot.build(:content)
  end

  describe 'コンテンツ投稿' do
    context 'コンテンツが投稿できるとき' do
      it "タイトル、画像、動画、概要、詳細、URLを適切に入力すると投稿できる" do
        expect(@content).to be_valid
      end
      it "画像がなくても動画があれば投稿できること" do
        @content.image_content = nil
        expect(@content).to be_valid
      end
      it "動画がなくても画像があれば投稿できること" do
        @content.video_content = nil
        expect(@content).to be_valid
      end
    end

    context 'コンテンツが投稿できないとき' do
      it "タイトルが空だと投稿できない" do
        @content.title = nil
        @content.valid?
        expect(@content.errors.full_messages).to include("Title can't be blank")
      end
      it "画像と動画が空だと投稿できない" do
        @content.image_content = nil
        @content.video_content = nil
        @content.valid?
        expect(@content.errors.full_messages).to include("Image content can't be blank", "Video content can't be blank")
      end
      it "概要が空だと投稿できない" do
        @content.overview = nil
        @content.valid?
        expect(@content.errors.full_messages).to include("Overview can't be blank")
      end
      it "詳細が空だと投稿できない" do
        @content.writing = nil
        @content.valid?
        expect(@content.errors.full_messages).to include("Writing can't be blank")
      end
      it "URLが空だと投稿できない" do
        @content.source = nil
        @content.valid?
        expect(@content.errors.full_messages).to include("Source can't be blank")
      end
    end
  end
end
