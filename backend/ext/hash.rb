
class Hash
  def slice(*keys)
    keys.each_with_object({}){|key, hash| hash[key] = self[key] }
  end
end
