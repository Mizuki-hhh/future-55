require 'rails_helper'
describe User do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it "役割、ユーザー名、Email、パスワード、パスワード確認用、生年月日、所属、プロフィールを入力すれば、登録できること" do
        expect(@user).to be_valid
      end
      it "プロフィールがなくても、登録できること" do
        @user.profile = nil
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it "ユーザー名が空だと登録できない" do
        @user.name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前を入力してください")
      end
      it "メールアドレスが空だと登録できない" do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスを入力してください")
      end
      it "メールアドレスに@が含まれていない場合登録できない" do
        @user.email = "testgmail.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスは不正な値です")
      end
      it "重複したメールアドレスが存在する場合登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("メールアドレスはすでに存在します")
      end
      it "パスワードが空だと登録できない" do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it "passwordが5文字以下だと登録できない" do
        @user.password = "000aa"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end
      it "passwordは半角数字だけだと登録できない" do
        @user.password = "000000"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end
      it "passwordは半角英字だけだと登録できない" do
        @user.password = "abcdef"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end
      it "passwordが存在してもpassword_confirmationが空だと登録できない" do
        @user.password_confirmation = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）を入力してください")
      end
      it "passwordとpassword_confirmationが不一致では登録できない" do
        @user.password = "123abc"
        @user.password_confirmation = "123abcd"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it "生年月日が空では登録できない" do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
      it "所属がないと登録できない" do
        @user.occupation = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("所属を入力してください")
      end
    end
  end
end