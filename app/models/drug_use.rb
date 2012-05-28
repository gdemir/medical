# encoding: utf-8
class DrugUse < ActiveRecord::Base
  belongs_to :consult    # department_id sahip
  belongs_to :drug       # department_id sahip
end
