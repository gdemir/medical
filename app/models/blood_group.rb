# encoding: utf-8
class BloodGroup < ActiveRecord::Base
  has_many :patient          # patient'ta blood_group_id kullanılıyor
end
