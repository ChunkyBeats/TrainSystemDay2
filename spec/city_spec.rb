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


  describe('#update') do
    it('changes the name of a city') do
      city = City.new(name: "BigRed")
      city.save()
      city.update("Thomas the Tank")
      expect(city.name).to(eq("Thomas the Tank"))
    end
  end

end
