class BooksController < ApplicationController
  def index
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @books = Book.all.sort_by { |book| -book.favorites.where(created_at: from...to).count }
    @book = Book.new
    @users = User.all
    @user = current_user
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