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

get '/projects/new' do
	erb :new
end

post '/projects' do # projects#create
	project = Project.new(params[:project])
	project.validate_links
	if project.save
		redirect to "/projects/#{project.id}"
	else
		erb :new
	end
end

post '/projects/search' do
	@projects = Project.search_projects(params)
end

get '/projects/:id' do
	@project = Project.find params[:id]
	erb :show
end

get '/projects/:id/edit' do
	@project = Project.find(params[:id])
	erb :edit
end

put '/projects/:id' do
	project = Project.find(params[:project][:id])
	project.update_attributes(params[:project])
	redirect to "projects/#{@project.id}"
end

delete '/projects/:id' do
	if logged_in? && admin_priviledge? == true
		project = Project.find(params[:id])
	end
	redirect to '/'
end


