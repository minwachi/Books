class UsersController < ApplicationController
  
  before_action :authenticate_user!, only: [:show, :new, :index, :edit]

  def show
        @user = User.find(params[:id])
        @books = @user.books
        @book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def index
  	    @users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
        user = current_user
        @book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）

  end

  def edit
        @user = User.find(params[:id])
        redirect_to user_path(current_user) unless @user.id == current_user.id
  end

  def update
        @user = User.find(params[:id])
        if  @user.update(user_params)
            redirect_to @user, notice: "You have updated user successfully."
        else
            render "edit"
        end
  end

private

  def user_params
        params.require(:user).permit(:name, :introduction, :profile_image)
  end

end

