class Patient < ActiveRecord::Base
  has_many :consult  # consult'ta patient_id kullanılıyor

  def full_name
    self.first_name + " " + self.last_name
  end

  def last_visit
    Consult.find_all_by_patient_id(self.id).last
  end

  def last_visit_date
    last_visit.date
  end

  def last_visit_doctor
    last_visit.doctor.full_name
  end
end
