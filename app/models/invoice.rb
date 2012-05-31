# encoding: utf-8
class Invoice < ActiveRecord::Base
  belongs_to :consult    # consult_id sahip
end
