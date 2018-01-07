module SessionsHelper
  def current_user
  	# @current_user に既に現在のログインユーザが代入されていたら何もせず、代入されていなかったら、
  	# User.find_by(...) からログインユーザを取得し、@current_user に代入する
  	# User.find_by(id: id) は、見つからなかった場合にはただ nil を返すだけでエラーは発生しない
  	# ※User.find(id) を使用してしまうと id には多くの場合で nil であり、ログインしていないだけでエラーページが表示される
    @current_user ||= User.find_by(id: session[:user_id])

		# 上記は下記のプログラムを一行にまとめて書いたもの
		# if @current_user
		#   return @current_user
		# else
		#   @current_user = User.find_by(id: session[:user_id])
		#   return @current_user
		# end
  end

  def logged_in?
    !!current_user # ログインしていればtrueを、ログインしていなければfalseを返す

		# 上記は下記のプログラムを一行にまとめて書いたもの
		# if current_user
		#   return true
		# else
		#   return false
		# end
  end
end
