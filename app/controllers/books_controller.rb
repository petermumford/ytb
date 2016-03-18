class BooksController < ApplicationController

  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.js { }
        format.html { redirect_to @book.user, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.js { render status: :unprocessable_entity }
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.destroy
        format.js { }
        format.html { redirect_to @book.user, notice: 'Book was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    def book_params
      params.require(:book).permit(:title, :user_id)
    end
end
