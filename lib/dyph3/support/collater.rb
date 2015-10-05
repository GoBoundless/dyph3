module Dyph3
  module Support
    module Collater
      extend self

      def collate_merge(left, base, right, merge_result)
        merge_result = merge_non_conflicts(merge_result.dup)
        if merge_result.empty?
          [
            [],
            false,
            [ {type: :non_conflict, text: [] } ]
          ]
        elsif merge_result.length == 1 && merge_result[0][:type] == :non_conflict
          [
            merge_result[0][:text],
            false,
            [ {type: :non_conflict, text: merge_result[0][:text]} ]
          ]
        else
          [
            base,
            true,
            merge_result
          ]
        end
      end

      private

        # @param [in] conflicts
        # @returns the list of conflicts with contiguous parts merged if they are non_conflicts
        def merge_non_conflicts(result, i = 0)
          while i < result.length - 1
            if result[i][:type] == :non_conflict && result[i+1][:type] == :non_conflict
              #result[i][:text] += "\n" unless result[i][:text][-1] == "\n"
              result[i][:text] += result.delete_at(i+1)[:text]
            else
              i += 1
            end
          end
          result
        end

    end
  end
end