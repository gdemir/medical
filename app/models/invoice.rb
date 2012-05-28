# encoding: utf-8
class Invoice < ActiveRecord::Base
  belongs_to :consult    # consult_id sahip

  def q
    total = 0
    all_product.each {|product| total += product[:price] * product[:sequence]}
    total
  end
end
