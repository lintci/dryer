require 'spec_helper'
require 'jsonapi_resource'

describe JSONAPIResource do
  describe '#deserialize' do
    let(:document) do
      {
        'data' => {
          'id' => '123', 'type' => 'cats',
          'attributes' => {'purr' => 'grrr'},
          'relationships' => {
            'legs' => {
              'data' => [
                {'id' => '1', 'type' => 'legs'},
                {'id' => '2', 'type' => 'legs'}
              ]
            },
            'head' => {'data' => {'id' => '2', 'type' => 'heads'}}
          }
        },
        'included' => [
          {'id' => '1', 'type' => 'legs', 'attributes' => {'length' => 1}},
          {'id' => '2', 'type' => 'legs', 'attributes' => {'length' => 1}},
          {'id' => '2', 'type' => 'heads', 'relationships' => {'ears' => {'data' => {'id' => '1', 'type' => 'ears'}}}}
        ],
        'meta' => {
          'dog' => false
        }
      }
    end
    subject(:resource){described_class.new(document)}

    it 'generates a nested hash of data' do
      expect(resource.deserialize).to eq(
        [
          {
            'purr' => 'grrr',
            'id' => '123',
            'legs' => [
              {'length' => 1, 'id' => '1'},
              {'length' => 1, 'id' => '2'}
            ],
            'head' => {'id' => '2', 'ear_id' => '1'}
          },
          {
            'dog' => false
          }
        ]
      )
    end
  end
end
