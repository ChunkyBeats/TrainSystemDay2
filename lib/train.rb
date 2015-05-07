class Train
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
    temp_id = DB.exec("INSERT INTO trains (name) VALUES ('#{@name}') RETURNING id;")
    @id = temp_id.first["id"].to_i
  end

  def self.all
    returned_trains = []
    trains = DB.exec("SELECT * FROM trains")
    trains.each() do |train| #train is returned as a hash cause of each method
      name = train.fetch("name")
      id = train.fetch("id").to_i
      returned_trains.push(Train.new({:id => id, :name => name}))
    end
    returned_trains
  end

  def ==(another_train)
    self.name == another_train.name
  end

  def self.find(id)
    train = DB.exec("SELECT * FROM trains WHERE id='#{id}';")
    name = train.first.fetch("name")
    Train.new(name: name, id: id)
  end

  def delete
    DB.exec("DELETE FROM stops WHERE train_id = #{self.id};")
    DB.exec("DELETE FROM trains WHERE id = '#{self.id}';")
  end

  def update(new_name)
    @name = new_name
    DB.exec("UPDATE trains SET name = '#{@name}' WHERE id = '#{self.id}';")
  end

  def get_cities
    cities = []
    pg_cities = DB.exec("SELECT * FROM stops WHERE train_id = #{self.id}")
    pg_cities.each() do |city| # is a hash
      id = city.fetch("city_id").to_i
      name = DB.exec("SELECT name FROM cities WHERE id = #{id}")[0].fetch('name')
      cities.push(City.new(:id => id, :name => name))
    end
    cities
  end

  def update(attributes)
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE trains SET name = '#{@name}' WHERE id = '#{self.id}';")

    attributes.fetch(:city_ids, []).each do |city_id|
      DB.exec("INSERT INTO stops (city_id, train_id) VALUES (#{city_id}, #{self.id});")
    end
  end

  # def stops do
  #   stop_array = []
  # end


end
