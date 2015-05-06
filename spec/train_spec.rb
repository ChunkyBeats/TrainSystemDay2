require('rspec')
require('train')
require('spec_helper')

describe(Train) do
  describe('#stops') do
    it('starts off as an empty list of all the cities a train stops in') do
      train = Train.new({})
      expect(train.stops).to(eq([]))
    end
  end

  describe('.all') do
    it('starts off empty') do
      expect(Train.all).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a train object into the DB') do
      train = Train.new(name: "Bob")
      train.save()
      expect(Train.all).to(eq([train]))
    end
  end

  describe('#==') do
    it('creates a custom equal method so that same name implies equality') do
      train = Train.new(name: "Charlie")
      train2 = Train.new(name: "Charlie")
      expect(train).to(eq(train2))
    end
  end

  describe('.find') do
    it('returns the train object given the id') do
      train = Train.new(name: "Thom")
      train.save()
      expect(Train.find(train.id)).to(eq(train))
    end
  end

  describe('#delete') do
    it('deletes a train') do
      train = Train.new(name: 'Thom')
      train.save()
      train.delete()
      expect(Train.all).to(eq([]))
    end
  end


  describe('#update') do
    it('changes the name of a train') do
      train = Train.new(name: "BigRed")
      train.save()
      train.update("Thomas the Tank")
      expect(train.name).to(eq("Thomas the Tank"))
    end
  end


end
