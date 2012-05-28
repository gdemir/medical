# encoding: utf-8
class Doctor < ActiveRecord::Base
  belongs_to :department    # department_id sahip
  has_many :consult         # consult'ta doctor_id kullanıyor

  def full_name
    self.first_name + " " + self.last_name
  end
end
