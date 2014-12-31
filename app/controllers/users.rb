get '/user/:name' do
	@current_user = current_user
	@logged_in = logged_in?
	@user = User.where("name = ?", params[:name]).first
	erb :user
end

get '/logout' do
	session[:user_id] = nil
	redirect '/'
end

get '/login' do

	erb :login
end

post '/login' do
	@user = User.where("name = ?", params[:username]).first
	if @user == nil
		@error = "That name doesn't exist"
		erb :login
	else
		session[:user_id] = @user.id
		erb :user
	end

end

post '/newuser' do
	if User.new(name: params[:username]).valid?
		@user = User.create(name: params[:username].downcase)
		session[:user_id] = @user.id
		erb :user
	else
		@error = "This name already exists!"
		erb :login
	end
end