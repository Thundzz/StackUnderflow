class Post < ActiveRecord::Base
  attr_accessible :content, :title, :editionNo

  def print_content

  	"#{self.content}"
  	
  end

def self.search(search)
  if search
    find(:all, :conditions => ['LOWER(title) LIKE LOWER(?)', "%#{search}%"])
  else
    find(:all)
  end
end

end
