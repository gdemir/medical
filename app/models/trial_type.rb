# encoding: utf-8
class TrialType < ActiveRecord::Base
  has_many :trial_request       # trial_request'te trial_type_id kullanıyor
  has_many :trial_storage
end
