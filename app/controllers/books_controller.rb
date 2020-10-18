class BooksController < ApplicationController

	def index
		# fetch_books to fetch all books using API
		@books = BookService.fetch_books
	end

	def show
		@book = BookService.get(book_id: params[:id])

		# Return to home page if records for book id not exist
		redirect_to root_path, error: "Book not found" unless @book.present?
	end
end
