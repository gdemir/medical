# encoding: utf-8
class TrialStorage < ActiveRecord::Base
  belongs_to :trial_type       # trial_type_id sahip
end
