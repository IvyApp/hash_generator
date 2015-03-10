require 'hash_builder'

RSpec.describe HashBuilder do
  let(:builder) { described_class.new }

  subject { builder.to_h }

  describe '#push_scope' do
    it 'pushes an object into the outer scope' do
      builder.new_array
      builder.new_object
      builder.store(:key, 1)
      builder.push_scope
      builder.store_scope(:array)

      should eq(:array => [{:key => 1}])
    end
  end

  describe '#reopen_scope' do
    it 'reopens the scope at the given key' do
      builder.new_object
      builder.store(:key1, 1)
      builder.store_scope(:object)
      builder.reopen_scope(:object)
      builder.store(:key2, 2)
      builder.end_scope

      should eq(:object => {:key1 => 1, :key2 => 2})
    end
  end

  describe '#store' do
    it 'stores a value in the current scope at the given key' do
      builder.store(:key, 1)

      should eq(:key => 1)
    end
  end

  describe '#store_scope' do
    it 'stores the current scope in the outer scope at the given key' do
      builder.new_object
      builder.store(:key, 1)
      builder.store_scope(:object)

      should eq(:object => {:key => 1})
    end
  end
end
