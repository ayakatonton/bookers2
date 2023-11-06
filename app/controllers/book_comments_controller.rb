class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
     comment.save
    redirect_to book_path(book)
  end
  
  def destroy
    is_matching_login_user
    current_user.book_comments.find(params[:id]).destroy!
    flash[:notice] = 'コメントを削除しました'
    redirect_to("/books/#{params[:book_id]}")
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
  
  def is_matching_login_user
    book_comment = BookComment.find(params[:id])
    unless book_comment.user.id == current_user.id
      redirect_to books_path
    end
  end

end
