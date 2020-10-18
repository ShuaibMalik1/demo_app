module BookService
	attr_accessor :response, :books

	module_function
	# HTTParty is used to fetch response from given url
	# ruby ||= operator is a handy way to assign variables if they are not defined yet, 
	# but not change the variable if they are already defined
	def fetch_books
		@response ||= HTTParty.get('https://www.googleapis.com/books/v1/volumes?filter=free-ebooks&q=a')
	
		@books ||= if @response.success?
			JSON.parse(@response.body)['items']
		else
			[] 
		end
	end

	# Return particular book based on book id.
	# fetch books if books are not present
	def get(book_id:)
		fetch_books unless @books.present?

		@books.select{|item| item['id'] == book_id}.first
	end
end