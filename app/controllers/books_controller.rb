class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  
  def new
    @books = Book.new  
  end
  
  
  def index
    @book=Book.new
    @books = Book.all
    @comment = current_user.book_comments.new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to @book
    else
      @books = Book.all
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    @newbook = Book.new
    @user = @book.user
    @comment = current_user.book_comments.new
  end
  
  def edit
    @book=Book.find(params[:id]) 
  end
  
  def  update
    @book=Book.find(params[:id])
  
    if @book.update(book_params)  
    flash[:notice] = "Book was successfully updated."
    redirect_to book_path(@book.id)
    else 
    render :edit
    end
  
  end
   
  def destroy
   
    @book=Book.find(params[:id])
    @book.destroy
    redirect_to '/books'
  end
   
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
      redirect_to books_path
    end
  end
end
