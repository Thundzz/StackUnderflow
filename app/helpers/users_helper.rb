# -*- coding: utf-8 -*-
module UsersHelper
  def show_study(study)
    if study == 1
      "<span class=\"label label-info\">Informatique</span>"
    elsif @user.study == 2
      "<span class=\"label label-success\">Matméca</span>"
    elsif @user.study == 3
      "<span class=\"label label-warning\">Electronique</span>"
    elsif @user.study == 4
      "<span class=\"label label-danger\">Télécommunication</span>"
    end
  end
end
