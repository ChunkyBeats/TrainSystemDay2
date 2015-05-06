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

  def get_trains
    trains = []
    pg_trains = DB.exec("SELECT * FROM stops WHERE city_id = #{self.id}")
    pg_trains.each() do |train| # is a hash
      id = train.fetch("train_id").to_i
      name = DB.exec("SELECT name FROM trains WHERE id = #{id}")[0].fetch('name')
      trains.push(Train.new(:id => id, :name => name))
    end
    trains
  end

  def update(attributes)
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = '#{self.id}';")

    attributes.fetch(:train_ids, []).each do |train_id|
      DB.exec("INSERT INTO stops (train_id, city_id) VALUES (#{train_id}, #{self.id});")
    end
  end




end








#
