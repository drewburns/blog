get '/tag/:name' do
	@tag = Tag.where("name = ?", params[:name] ).first
	if @tag == nil
		@posts = []
	else
		@posts = @tag.posts
	end
	erb :posts
end