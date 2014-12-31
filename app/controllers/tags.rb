get '/tag/:name' do
	@current_user = current_user
	@logged_in = logged_in?
	@tag = Tag.where("name = ?", params[:name] ).first
	if @tag == nil
		@posts = []
	else
		@posts = @tag.posts
	end
	erb :posts
end