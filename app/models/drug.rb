# encoding: utf-8
class Drug < ActiveRecord::Base
  has_many :drug_use
  has_many :drug_storage
end
