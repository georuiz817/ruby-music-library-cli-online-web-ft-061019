module Concerns::Findable
  def self.find_by_name(name)
  all.find {|x| x.name == name}
end

end
  
end