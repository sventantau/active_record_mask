require 'spec_helper'

RSpec.describe ActiveRecordMask do
  let(:record) { SomeClass.new(title: 'Real Title', description: 'Real Description', some_integer: 42) }

  context 'when reading is not allowed' do
    it 'returns default values for attributes' do
      expect(record.title).to eq('hidden')
      expect(record.description).to eq('')
      expect(record.some_integer).to eq(0)
      expect(record.some_method).to eq('no change here!')
    end

    it 'returns empty associations' do
      record.another_classes.build
      expect(record.another_classes).to be_empty
    end
  end

  context 'when reading is allowed' do
    before { record.mask_down! }

    it 'returns real values for attributes' do
      expect(record.title).to eq('Real Title')
      expect(record.description).to eq('Real Description')
      expect(record.some_integer).to eq(42)
      expect(record.some_method).to eq('no change here!')
    end

    it 'returns real associations' do
      record.another_classes.build
      expect(record.another_classes).not_to be_empty
    end
  end
end



RSpec.describe ActiveRecordMask do
  let(:record) { AnotherClass.new(title: 'Real Title', description: 'Real Description', some_integer: 42) }

  context 'when reading is not allowed' do
    before { record.mask_up! }

    it 'returns default values for attributes' do
      expect(record.title).to eq('')
      expect(record.description).to eq('hello default')
      expect(record.some_integer).to eq(42)
    end

    it 'returns allowed associations' do
      record.some_classes.build
      expect(record.some_classes).not_to be_empty
    end
  end

  context 'when reading is allowed (default)' do

    it 'returns real values for attributes' do
      expect(record.title).to eq('Real Title')
      expect(record.description).to eq('Real Description')
      expect(record.some_integer).to eq(42)
    end

    it 'returns real associations' do
      record.some_classes.build
      expect(record.some_classes).not_to be_empty
    end
  end
end

RSpec.describe ActiveRecordMask do
  let(:record) { MoreClass.new(title: 'Real Title', description: 'Real Description', some_integer: 42) }

  context 'default reading is not allowed' do

    it 'returns default values for attributes' do
      expect(record.title).to eq('')
      expect(record.description).to eq('')
      expect(record.some_integer).to eq(0)
    end

    it 'returns no allowed associations' do
      record.some_classes.build
      expect(record.some_classes).to be_empty
    end
  end

  context 'when reading is allowed' do
    before { record.mask_down! }

    it 'returns real values for attributes' do
      expect(record.title).to eq('Real Title')
      expect(record.description).to eq('Real Description')
      expect(record.some_integer).to eq(42)
    end

    it 'returns real associations' do
      record.some_classes.build
      expect(record.some_classes).not_to be_empty
    end
  end
end
