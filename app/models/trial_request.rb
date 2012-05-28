# encoding: utf-8
class TrialRequest < ActiveRecord::Base
  belongs_to :trial_type       # trial_type_id sahip
  belongs_to :consult          # consult_id sahip
  has_many :trial_result       # trial_result'te trial_request_id kullanıyor
end
