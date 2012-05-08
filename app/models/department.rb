class Department < ActiveRecord::Base
  has_many :doctor       # doctor'ta department_id kullanıyor
end
