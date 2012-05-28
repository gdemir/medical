# encoding: utf-8
class TrialResult < ActiveRecord::Base
  belongs_to :trial_request       # trial_request_id sahip
  belongs_to :trial               # trial_id sahip
end
