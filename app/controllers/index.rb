get '/' do	
	redirect to '/projects'
end

get '/projects' do   #  projects#index
	@projects = Project.all
  erb :index
end

get '/projects/new' do # projects#new
	
	erb :new
end

post '/projects' do # projects#create

end

get '/projects/:id' do # projects#show

	erb :show
end

get '/projects/:id/edit' do # projects#edit

	erb :edit
end

delete '/projects/:id' do # projects#destroy


end


