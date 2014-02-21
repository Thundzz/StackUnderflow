module UsersHelper
	def show_study(study)
		if study == 1
	    	"<span class=\"label label-info\">Informatique</span>"
	    else if @user.study == 2
	    	"<span class=\"label label-success\">Matméca</span>"
	    else if @user.study == 3
	    	"<span class=\"label label-warning\">Electronique</span>"
	    else if @user.study == 4
	    	"<span class=\"label label-important\">Télécommunication</span>"
	    end
		end
		end
	    end
	end

end
