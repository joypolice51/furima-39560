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
  end

  context '内容に問題がある場合' do
    it "postal_code, prefecture_id, city, house_number, phone_numberが空では保存ができないこと" do
      @order_address.building = ''
      expect(@order_address).to be_valid
    end

    it "tokenが空では登録できないこと" do
      @order_address.token = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Token can't be blank")
    end
  end
 end

end
