# encoding: utf-8
class Patient < ActiveRecord::Base
  belongs_to :blood_group  # blood_group_id sahip
  has_many :consult        # consult'ta patient_id kullanılıyor

  include ApplicationHelper  # consult_days için

  def full_name
    self.first_name + " " + self.last_name
  end

  def age
    (Time.now - self.birthday.year.years - self.birthday.mon.month - self.birthday.day.days).strftime("%Y").to_i
  end

  def last_visit
    Consult.find_all_by_patient_id(self.id).last
  end

  def last_visit_date
    last_visit.date
  end

  def last_visit_department_and_doctor
    last_visit.doctor.department.name + "/" + last_visit.doctor.full_name
  end

  def consults
    Consult.find_all_by_patient_id(self.id)
  end

  def new_consults
    Consult.where("patient_id", self.id).where("date >=? ", consult_days[0])
  end

end
