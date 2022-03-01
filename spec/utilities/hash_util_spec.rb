require 'rails_helper'

describe HashUtil do
  describe '.get' do
    let!(:valid_hash) do
      {
        name: 'Test Name',
        description: 'Test Description',
        location: {
          lat: 1.264751,
          lng: 103.824006,
          address: '8 Sentosa Gateway, Beach Villas, 098269',
          city: 'Singapore',
          country: 'Singapore'
        },
        images: [
          {
            link: 'https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg',
            description: 'Double room'
          }, {
            link: 'https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/4.jpg',
            description: 'Bathroom'
          }
        ]
      }
    end

    context 'when provides path is string' do
      where(:path, :expected_result) do
        [
          ['name', 'Test Name'],
          ['location.lat', 1.264751],
          ['images.0.link', 'https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg']
        ]
      end

      with_them do
        it 'returns exactly value' do
          result = described_class.get(valid_hash, path)

          expect(result).to eq(expected_result)
        end
      end
    end

    context 'when provides path is symbol' do
      where(:path, :expected_result) do
        [
          [:name, 'Test Name'],
          [:description, 'Test Description'],
        ]
      end

      with_them do
        it 'returns exactly value' do
          result = described_class.get(valid_hash, path)

          expect(result).to eq(expected_result)
        end
      end
    end

    context 'when provides path is array' do
      where(:path, :expected_result) do
        [
          [['name'], 'Test Name'],
          [['location', 'lat'], 1.264751],
          [['images', '0', 'link'], 'https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg'],
          [['images', 0, 'link'], 'https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg']
        ]
      end

      with_them do
        it 'returns exactly value' do
          result = described_class.get(valid_hash, path)

          expect(result).to eq(expected_result)
        end
      end
    end

    context 'when provides format type' do
      where(:path, :type, :expected_result) do
        [
          ['name', :hash, 'Test Name'],
          ['invalid_key', :hash, { }],
          ['location.lat', :string, '1.264751'],
          ['invalid_key', :string, ''],
          ['images.0.link', :array, ['https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg']],
          ['invalid_key', :array, []],
          ['invalid_key', :number, nil],
        ]
      end

      with_them do
        it 'returns exactly value according format type' do
          result = described_class.get(valid_hash, path, type: type)

          expect(result).to eq(expected_result)
        end
      end
    end

    context 'when provides hash_mapping' do
      where(:path, :type, :hash_mapping, :expected_result) do
        [
          ['images.0', :hash, { link: :url }, { url: 'https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg' }],
          ['images', :array, { link: :url }, [
            { url: 'https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg' },
            { url: 'https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/4.jpg' },
          ]],
        ]
      end

      with_them do
        it 'returns exactly with new hash key' do
          result = described_class.get(valid_hash, path, type: type, hash_mapping: hash_mapping)

          expect(result).to eq(expected_result)
        end
      end
    end
  end

  describe '.flatten_hash' do
    context 'when provides nested hash' do
      let(:nested_hash) do
        {
          name: 'Test Name',
          description: 'Test Description',
          location: {
            lat: 1.264751,
            lng: 103.824006,
            country: 'Singapore'
          },
          images: [{
            link: 'https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/4.jpg',
            description: 'Bathroom'
          }]
        }
      end

      it 'returns new hash' do
        result = described_class.flatten_hash(nested_hash)

        expect(result).to include(
          'name' => 'Test Name',
          'description' => 'Test Description',
          'location.lat' => 1.264751,
          'location.lng' => 103.824006,
          'location.country' => 'Singapore',
          'images.[0].link' => 'https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/4.jpg',
          'images.[0].description' => 'Bathroom'
        )
      end
    end

    context 'when provides array hash' do
      let(:array_hash) do
        [{
          name: 'Test Name',
          description: 'Test Description',
          location: {
            lat: 1.264751,
            lng: 103.824006,
            country: 'Singapore'
          },
          images: [{
            link: 'https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/4.jpg',
            description: 'Bathroom'
          }]
        }]
      end

      it 'returns new hash' do
        result = described_class.flatten_hash(array_hash)

        expect(result).to include(
          '[0].name' => 'Test Name',
          '[0].description' => 'Test Description',
          '[0].location.lat' => 1.264751,
          '[0].location.lng' => 103.824006,
          '[0].location.country' => 'Singapore',
          '[0].images.[0].link' => 'https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/4.jpg',
          '[0].images.[0].description' => 'Bathroom'
        )
      end
    end
  end
end
