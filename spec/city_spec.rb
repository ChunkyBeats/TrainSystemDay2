require('spec_helper')

describe(City) do
  describe('.all') do
    it('starts off empty') do
      expect(City.all).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a city object into the DB') do
      city = City.new(name: "Bob")
      city.save()
      expect(City.all).to(eq([city]))
    end
  end

  describe('#==') do
    it('creates a custom equal method so that same name implies equality') do
      city = City.new(name: "Charlie")
      city2 = City.new(name: "Charlie")
      expect(city).to(eq(city2))
    end
  end

  describe('.find') do
    it('returns the city object given the id') do
      city = City.new(name: "Thom")
      city.save()
      expect(City.find(city.id)).to(eq(city))
    end
  end

  describe('#delete') do
    it('deletes a city') do
      city = City.new(name: 'Thom')
      city.save()
      city.delete()
      expect(City.all).to(eq([]))
    end
  end

  describe('#get_trains and #update') do
    it('adds trains to a city and updates the city to include those trains') do
      city = City.new(name: "BigRed")
      city.save()
      a_train = Train.new(name: 'A')
      a_train.save()
      b_train = Train.new(name: 'B')
      b_train.save()
      city.update(:train_ids => [a_train.id, b_train.id])
      expect(city.get_trains).to(eq([a_train, b_train]))
    end
  end

end
