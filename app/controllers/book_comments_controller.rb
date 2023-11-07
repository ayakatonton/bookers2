class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = @book.id
    comment.save
    # book_path(book)
    @book_comment=BookComment.new
    render "comment"
  end
  
  def destroy
    @book_comment = BookComment.find(params[:id])
    @book = @book_comment.book
    @book_comment.destroy
    # flash[:notice] = 'コメントを削除しました'
    @book_comment=BookComment.new
    # ("/books/#{params[:book_id]}")
    render "comment"
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
  
  # def is_matching_login_user
  #   book_comment = BookComment.find(params[:id])
  #   unless book_comment.user.id == current_user.id
  #     # books_path
  #   end
  # end

end
