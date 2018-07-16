class Recipe
  attr_reader :name, :description, :url, :prep_time, :cook_time, :difficulty, :done
  attr_writer :done
  def initialize(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
    @url = attributes[:url]
    @prep_time = attributes[:prep_time]
    @cook_time = attributes[:cook_time]
    @difficulty = attributes[:difficulty]
    @done = attributes[:done]
  end
  def done?
    @done
  end
end
