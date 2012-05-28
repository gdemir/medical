# encoding: utf-8
class Trial < ActiveRecord::Base
  has_many :trial_result       # trial_result'te trial_id kullanıyor
end
