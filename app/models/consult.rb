class Consult < ActiveRecord::Base
  include ApplicationHelper  # turkish_day için
  belongs_to :patient        # patient_id sahip
  belongs_to :doctor         # doctor_id sahip
  has_many :invoice          # consult'ta patient_id kullanılıyor

  def hour
    self.date.strftime("%H:%M:%S")
  end

  def day
    self.date.strftime("%d-%m-%Y") + " " + turkish_day(self.date.wday)
  end
end
