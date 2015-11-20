require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest

  test "buying a product" do
    # テスト準備
    LineItem.delete_all         # ------
    Order.delete_all            # お掃除
    Cart.delete_all             # ------
    ruby_book = products(:ruby) # 購入したい本

    # ユーザーがオンラインストアのインデックスページを訪れる
    get "/"                   # http://localhost:3000にgetでアクセス
    assert_response :success  # レスポンスが返ってくる？
    assert_template "index"   # indexが表示される？

    # ユーザーが商品を選択してカートに入れる
    post_via_redirect "/line_items", product_id: ruby_book.id  # リダイレクトして/Line_itemsにpostでアクセス
    assert_response :success                                   # レスポンスが返ってくる？
    assert_template "show"                                     # showが表示される？

    cart = Cart.find(session[:cart_id])                 # 現セッションのカートの特定
    assert_equal 1, cart.line_items.size                # カートの中に1個入ってる？
    assert_equal ruby_book, cart.line_items[0].product  # カートの中にあるのはruby_book？

    # ユーザーがチェックアウトする
    get "/orders/new"         # /orders/newにgetでアクセス
    assert_response :success  # レスポンスが返ってくる？
    assert_template "new"     # newが表示される？

    post_via_redirect "/orders",  # 注文したユーザーの情報入力とリダイレクト
                      order: {name:     "Dave Thomas",
                              address:  "123 The Street",
                              email:    "dave@example.com",
                              pay_type: "現金"}

    assert_response :success              # レスポンスが返ってくる？
    assert_template "index"               # indexが表示される？
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size  # カートの中がからっぽになる？

    orders = Order.all           # 注文データを格納
    assert_equal 1, orders.size  # オーダーの中に1個入ってる？

    # 注文確定後、メールが送信される
    mail = ActionMailer::Base.deliveries.last   # 最後に送信したメールの情報を格納
    assert_equal ["dave@example.com"], mail.to  # 入力されたメアド宛てに送信してる？
  end
end
