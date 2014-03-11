
module ApplicationHelper
  def avatar_url(user,taille)
    default_url = "#{root_url}images/guest.png"
    if user.email.nil?
    
    "http://gravatar.com/avatar/?s="+taille.to_s+"&d=mm"
    else
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s="+taille.to_s+"&d=wavatar"
    end
 end
end
