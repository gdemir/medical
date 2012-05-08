# encoding: utf-8
module ApplicationHelper

  def require_admin
    redirect_to '/admin/login' unless session[:admin]
  end

  def require_superadmin
    require_admin
    redirect_to '/admin/login' unless session[:superadmin]
  end

  def consult_days
    # bugün ve yarının ne getireceği bilinmez.
    today = Date.today
    tomorrow = today.next_day
    days = [today, tomorrow]
    return days
  end

  def turkish_days
    %w{ Pazar Pazartesi Salı Çarşamba Perşembe Cuma Cumartesi }
  end

  def turkish_day index
    turkish_days[index]
  end

  def consult_times
    # doktor 08:00-12:00 arası çalışır.
    # hasta muayenesi 3 dakikadır.
    begin_min        = 8 * 60
    end_min          = 12 * 60
    examination_min  = 3
    return begin_min, end_min, examination_min
  end
end
