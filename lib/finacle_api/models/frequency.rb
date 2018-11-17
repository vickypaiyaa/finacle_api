require 'finacle_api/common/serializable_object'

module FinacleApi

  class Frequency < SerializableObject
    include ActiveModel::Dirty
    include ActiveModel::Validations

    attr_accessor :cal, :type, :start_dt, :week_day, :week_num, :hol_stat


    def freq_type
      case type
      when 'D'
        return 'Daily'
      when 'F'
        return 'Fortnightly'
      when 'H'
        return 'Half Yearly'
      when 'Y'
        return 'Yearly'
      when 'M'
        return 'Monthly'
      when 'Q'
        return 'Quarterly'
      when 'W'
        return 'Weekly'
      end
    end

    def calendar
      case cal
      when '00'
        return 'Gregorian'
      when '01'
        return 'Hirji'
      end
    end

    def holiday_pickup_status
      case hol_stat
      when 'N'
        return 'Next Day'
      when 'P'
        return 'Previous Day'
      when 'S'
        return 'Skip'
      end
    end


  end # InterestCalcFrequency

end