get '/posts' do
	@posts = Post.all
	erb :posts
end


get '/create' do

	erb :create
end

post '/create' do
	the_post = Post.new(title: params[:title],body: params[:body])
	if the_post.valid?
		post = Post.create(title: params[:title],body: params[:body])
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
	@post = Post.find(params[:id])
	erb :post
end

get '/post/:id/edit' do
	@post = Post.find(params[:id])
	erb :edit
end

post '/post/:id/edit' do
	@post = Post.find(params[:id])
	@post.update_attributes(title: params[:title],body: params[:body])
	erb :post
end

post '/post/:id/delete' do
	@post = Post.find(params[:id])
	@post.destroy

	erb :index
end