get '/' do
	@logged_in = logged_in?
	@current_user = current_user
	@posts = Post.last(5)
  erb :index
end
