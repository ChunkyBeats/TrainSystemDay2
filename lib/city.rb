class City
  attr_reader :name
  attr_accessor :stops, :id

  def initialize(params)
    if params.has_key?(:id)
      @id = params.fetch(:id)
    else
      @id = nil
    end
    if params.has_key?(:name)
      @name = params.fetch(:name)
    else
      @name = nil
    end
    @stops = []
  end

  def save
    temp_id = DB.exec("INSERT INTO cities (name) VALUES ('#{@name}') RETURNING id;")
    @id = temp_id.first["id"].to_i
  end

  def self.all
    returned_cities = []
    cities = DB.exec("SELECT * FROM cities")
    cities.each() do |city| #city is returned as a hash cause of each method
      name = city.fetch("name")
      id = city.fetch("id").to_i
      returned_cities.push(City.new({:id => id, :name => name}))
    end
    returned_cities
  end

  def ==(another_city)
    self.name == another_city.name
  end

  def self.find(id)
    city = DB.exec("SELECT * FROM cities WHERE id='#{id}';")
    name = city.first.fetch("name")
    City.new(name: name, id: id)
  end

  def delete
    DB.exec("DELETE FROM cities WHERE id = '#{self.id}';")
  end

  def update(new_name)
    @name = new_name
    DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = '#{self.id}';")
  end


end
