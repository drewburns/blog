get '/posts' do
	@logged_in = logged_in?
	@current_user = current_user
	@posts = Post.all
	erb :posts
end


get '/create' do
	if logged_in?
		@current_user = current_user
		erb :create
	else
		@error = "You need to login first"
		erb :login
	end
end

post '/create' do
	@current_user = current_user
	@logged_in = logged_in?

	the_post = Post.new(title: params[:title],body: params[:body], user_id: session[:user_id])
	if the_post.valid?
		post = Post.create(title: params[:title],body: params[:body], user_id: session[:user_id])
		tag_array = []
		holder = nil
		tags = params[:tags]
		tags.split(",").each do |tag|
			Tag.create(name: tag.chomp) unless Tag.exists?(:name => tag.chomp)
			holder = Tag.where("name = ?", tag.chomp ).first
			tag_array << holder
		end

		tag_array.each do |tag|
			Relationship.create(post_id: post.id, tag_id: tag.id)
		end

		@post = post
		erb :post
	else
		@error = "All the forms need to be filled in!"
		erb :create
	end
end

get '/post/:id' do
	@current_user = current_user
	@logged_in = logged_in?

	@post = Post.find(params[:id])
	@current_user = current_user
	@logged_in = logged_in?
	erb :post
end

get '/post/:id/edit' do
	@current_user = current_user
	@logged_in = logged_in?
	@post = Post.find(params[:id])
	if session[:user_id] == @post.user_id
		erb :edit
	else
		@error = "Log in to edit your post"
		erb :login
	end
end

post '/post/:id/edit' do
	@current_user = current_user
	@logged_in = logged_in?
	@post = Post.find(params[:id])
	@post.update_attributes(title: params[:title],body: params[:body])
	erb :post
end

post '/post/:id/delete' do
	@current_user = current_user
	@logged_in = logged_in?
	@post = Post.find(params[:id])
	@post.destroy

	redirect '/'
end