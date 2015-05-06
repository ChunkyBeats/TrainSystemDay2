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
    DB.exec("DELETE FROM trains WHERE id = '#{self.id}';")
  end

  def update(new_name)
    @name = new_name
    DB.exec("UPDATE trains SET name = '#{@name}' WHERE id = '#{self.id}';")
  end

  # def stops do
  #   stop_array = []
  # end


end
