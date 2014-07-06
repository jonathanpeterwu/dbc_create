def logged_in?
	@user ||= User.find(session[:id])
end

def admin_priviledge?
	if session
		user = User.find(session[:id])
		user.name == "admin"
		true
	else
		nil
	end
end