require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '購入情報の保存' do
  #pending "add some examples to (or delete) #{__FILE__}"

  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id:user.id, item_id:item.id)
  end

  context '内容に問題ない場合' do
    it "postal_code, prefecture_id, city, house_number, phone_number、tokenがあれば保存ができること" do
      expect(@order_address).to be_valid
    end

    it "building_nameがなくても保存ができること" do
      @order_address.building_name =  ''
      expect(@order_address).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it "postal_codeが空では保存ができないこと" do
      @order_address.postal_code = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("postal_code can't be blank")
    end

    it "prefecture_idが空では保存ができないこと" do
      @order_address.prefecture_id = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("prefecture_id can't be blank")
    end

    it "cityが空では保存ができないこと" do
      @order_address.city = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("city can't be blank")
    end

    it "house_numberが空では保存ができないこと" do
      @order_address.house_number = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("house_number can't be blank")
    end

    it "phone_numberが空では保存ができないこと" do
      @order_address.phone_number = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("phone_number can't be blank")
    end

    it "tokenが空では登録できないこと" do
      @order_address.token = nil
      @order_address.valid?
      expect(@order_address).not_to be_valid
      expect(@order_address.errors.full_messages).to include("Token can't be blank")
    end

    it 'postal_codeは、「3桁ハイフン4桁」の半角文字列でないと保存できないこと' do
      @order_address.postal_code = '1234567'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('postal_code is invalid')
    end

    it 'phone_numberは、10桁以上11桁以内の半角数値でないと保存できないこと' do
      @order_address.phone_number = '090-1234-5678'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('phone_number is invalid')
    end

  end

end
