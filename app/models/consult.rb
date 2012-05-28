# encoding: utf-8
class Consult < ActiveRecord::Base
  belongs_to :patient        # patient_id sahip
  belongs_to :doctor         # doctor_id sahip
  has_many :invoice          # consult'ta patient_id kullanılıyor
  has_many :trial_request    # trial_request'ta consult_id kullanılıyor

  include ApplicationHelper  # turkish_day için

  def hour
    self.date.strftime("%H:%M:%S")
  end

  def day
    self.date.strftime("%d-%m-%Y")
  end

  def weekday
    turkish_day(self.date.wday)
  end

  def day_and_weekday
     day + " " + weekday
  end

  def department_and_doctor
    self.doctor.department.name + "/" + self.doctor.full_name
  end

  def all_product
    Invoice.find_all_by_consult_id(self.id)
  end

  def total_price
    all_product.sum {|product| product[:price] * product[:sequence]}
  end

  def trial_requests
    TrialRequest.find_all_by_consult_id(self.id)
  end

  def drug_requests
    DrugUse.find_all_by_consult_id(self.id)
  end
end
