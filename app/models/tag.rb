class Tag < ActiveRecord::Base
  attr_accessible :description, :name

 has_and_belongs_to_many :questions

  def self.tokens(query)
    tags = where("name like ?", "%#{query}%")
    if tags.empty?
      [{id: "<<<#{query}>>>", name: "New: \"#{query}\""}]
    else
      tags
    end
  end

  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
    tokens.split(',')
  end


def self.search(search) #pour la recherche
  if search
    find(:all, :conditions => ['LOWER(name) LIKE LOWER(?)', "%#{search}%"])
  else
    find(:all)
  end
end

end
