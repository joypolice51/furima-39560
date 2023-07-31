class OrdersController < ApplicationController
  before_action :authenticate_user!  ##ログインしていない場合はログインページに飛ばす
  before_action :set_public_key, only: [:index, :create]
  before_action :item_find, only: [:index, :create]
  before_action :move_to_root_path, only: [:index]

 ##newアクションは今回は不要

  def index
    @order_address = OrderAddress.new  ## formオブジェクトのインスタンス生成
    @order = Order.new ##ここがおかしい。今から購入するのにallはおかしい。
  end

  def create ##https://master.tech-camp.in/v2/curriculums/8301 を参照
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?       #valid?が動くと、モデルに記述したwith_options内のバリデーションが動く。バリデーション内に記述したカラムが@order_addressに入っていないとダメ。
      pay_item
      @order_address.save         #order_addressモデルのsaveメソッドを呼ぶ
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity  
    end
  end

  private
  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

  def set_public_key
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  end

  def move_to_root_path
    if user_signed_in? && current_user.id == @item.user_id || @item.order.present?
      redirect_to root_path
    end
  end

  def item_find
    @item = Item.find(params[:item_id])
  end

end
