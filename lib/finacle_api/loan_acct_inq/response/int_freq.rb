require 'finacle_api/common/serializable_object' 
module FinacleApi
  module LoanAcctInq
    module ResponseEntity
      class IntFreq < SerializableObject
        attr_accessor :cal, :type, :start_dt, :week_day, :week_num, :hol_stat

        def to_frequency
            Frequency.new(cal: cal, type: type, start_dt: start_dt, 
                          week_day: week_day, week_num: week_num, hol_stat: hol_stat)
        end

      end
    end
  end
end
