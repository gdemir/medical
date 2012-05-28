# encoding: utf-8
class DrugStorage < ActiveRecord::Base
  belongs_to :drug       # drug_id sahip
end
