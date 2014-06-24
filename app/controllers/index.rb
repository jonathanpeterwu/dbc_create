get '/' do
	redirect to '/projects'
end

get '/projects' do
	if params[:sort]
		@projects = Project.sort_by(params)
	else
		@projects = Project.all
	end
  erb :index
end

get '/projects/new' do # projects#new
	erb :new
end

post '/projects' do # projects#create
	project = Project.create(params[:project])
	redirect to "/projects/#{project.id}"
end

post '/projects/search' do
	@projects = Project.search_projects(params)
end

get '/projects/:id' do # projects#show
	@project = Project.find params[:id]
	erb :show
end

get '/projects/:id/edit' do # projects#edit
	@project = Project.find(params[:id])
	erb :edit
end

put '/projects/:id' do
	@project = Project.find(params[:project][:id])
	@project.update_attributes(params[:project])
	redirect to "projects/#{@project.id}"
end



delete '/projects/:id' do # projects#destroy
	Project.find(params[:id]).destroy
	redirect to '/'
end


