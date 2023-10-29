class BooksController < ApplicationController
  def index
    @books = Book.all
    @book = Book.new
    @users = User.all
    @user = current_user
    
    # 過去一週間のいいね合計カウントが多い順にソート
    @books = @books.sort_by do |book|
    # ここで過去一週間のいいね合計カウントを計算
    # 仮に favorites_count メソッドを使う例
    book.favorites_count_for_last_week
    end.reverse
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end  
  end
  
  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @post_comment = PostComment.new
    @book_comment = BookComment.new
  end
  
  def edit
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end  
  end
  
   def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end  
   end
  
  def destroy
     @book = Book.find(params[:id])
     @book.destroy
     
     redirect_to books_path
  end
  
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end