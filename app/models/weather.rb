class Weather < ApplicationRecord
    validates :date, presence: true
    validates :hot_day, inclusion: { in: [ true, false ] }
end
