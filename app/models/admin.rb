# encoding: utf-8
class Admin < ActiveRecord::Base

  def full_name
    self.first_name + " " + self.last_name
  end

  def status_name
    if self.status == 1
      "Admin"
    elsif self.status == 0
      "Personel"
    else
      "Bir Kategoriye Koyulmadım"
    end
  end
end
