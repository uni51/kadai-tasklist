class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  before_action :correct_user, only: [:show]

  def index
    redirect_to root_path # ユーザー一覧は見せない
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks.order('updated_at DESC').page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user # users#show のアクションへリダイレクト（create アクション実行後に、更にshowアクションが実行される）
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # 認証用メソッド
  def correct_user
    user = User.find(params[:id])
    if current_user != user
      flash[:danger] = '権限がありません'
      redirect_to root_path
    end
  end
end
