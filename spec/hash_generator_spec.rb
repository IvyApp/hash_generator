require 'hash_generator'

RSpec.describe HashGenerator do
  let(:generator) { described_class.new }

  subject { generator.to_h }

  describe '#push_object' do
    it 'begins a new object scope, yields, then pushes the object into the outer scope' do
      generator.new_array
      generator.push_object do
        generator.store(:key, 1)
      end
      generator.store_scope(:array)

      should eq(:array => [{:key => 1}])
    end
  end

  describe '#push_scope' do
    it 'pushes the current scope into the outer scope' do
      generator.new_array
      generator.new_object
      generator.store(:key, 1)
      generator.push_scope
      generator.store_scope(:array)

      should eq(:array => [{:key => 1}])
    end
  end

  describe '#reopen_scope' do
    it 'reopens the scope at the given key' do
      generator.new_object
      generator.store(:key1, 1)
      generator.store_scope(:object)
      generator.reopen_scope(:object)
      generator.store(:key2, 2)
      generator.end_scope

      should eq(:object => {:key1 => 1, :key2 => 2})
    end
  end

  describe '#store' do
    it 'stores a value in the current scope at the given key' do
      generator.store(:key, 1)

      should eq(:key => 1)
    end
  end

  describe '#store_array' do
    it 'begins a new array scope, yields, then stores the array at the given key' do
      generator.store_array(:objects) do
        generator.new_object
        generator.store(:key, 1)
        generator.push_scope
      end

      should eq(:objects => [{:key => 1}])
    end
  end

  describe '#store_object' do
    it 'begins a new object scope, yields, then stores the object at the given key' do
      generator.store_object(:object) do
        generator.store(:key, 1)
      end

      should eq(:object => {:key => 1})
    end
  end

  describe '#store_scope' do
    it 'stores the current scope in the outer scope at the given key' do
      generator.new_object
      generator.store(:key, 1)
      generator.store_scope(:object)

      should eq(:object => {:key => 1})
    end
  end
end
