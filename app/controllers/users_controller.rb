require 'byebug'
enable :sessions
######################

get '/register' do
	puts "[LOG] Getting /register"
  puts "[LOG] Params: #{params.inspect}"
  erb :"user/new"
end


# In users_controller.rb
post '/register' do

  if logged_in?
    redirect '/'
  else
  	#params was automatically created into a hash
    user = User.new(params[:user])
    if user.save
      # what should happen if the user is saved?
      flash[:msg] = "Success!"
      session[:id] = user.id
      redirect '/'
    else  
      flash[:msg] = user.errors.full_messages
      redirect '/register'
    end
  end

=begin
In a POST method, put "redirect", not erb.

Why?

Because if you've done an action, and HTML is rendered, the link is still the same.

If people refresh, you resubmit in the action again (though it looks different). BAD! Imagine this is a payment page!

=end
end  
##########################

get '/login' do
  # puts "[LOG] Getting /login"
  # puts "[LOG] Params: #{params.inspect}"
  if logged_in?
    redirect '/'
  else
    erb :"session/new"
  end
end

post '/login' do
	result = User.password_correct?(params[:user][:email], params[:user][:password])
  # apply a authentication method to check if a user has entered a valid email and password
  # if a user has successfully been authenticated, you can assign the current user id to a session
  if result == false
  	# @err = "Wrong email or password"
  	flash[:msg] = "Wrong email or password"
  	redirect "/login"
  else
  	flash[:msg] = "ACCESS GRANTED"
  	session[:id] = result.id
  	redirect '/'
	end
end

post '/logout' do
	session[:id] = nil
	# redirect "/"
	# byebug
	erb :"session/new"
  # kill a session when a user chooses to logout, for example, assign nil to a session
  # redirect to the appropriate page
end


#########################

get '/users/:id' do
  # some code here
  id = params[:id]   # string!
  @user = User.find(id.to_i)

  if @user.nil?
  	redirect '/' 
  else
  	erb :"user/show"
  end
end

