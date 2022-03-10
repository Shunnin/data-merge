require 'rails_helper'

describe GBlendingData::Strategies::CombineStrategy do
  describe 'when given duplicate data' do
    where(:given_compare_data, :expected_result) do
      [
        [[['Outdoor pool', 'indoor pool'], ['pool', 'inDOOR pool']], ['Indoor pool', 'Outdoor pool']],
        [[['Outdoor pool', 'indoor pool'], ['pool', 'indoor pool']], ['Indoor pool', 'Outdoor pool']],
        [[['pool', 'indoor pool', 'outdoor POOl'], ['outdoor pool', 'inDOOR pool']], ['Indoor pool', 'Outdoor pool']],
      ]
    end

    with_them do
      it 'returns the uniq data' do
        merge_strategies = { combine: true }

        result = described_class.new(merge_strategies, given_compare_data).execute

        expect(result).to match_array(expected_result)
      end
    end
  end
end