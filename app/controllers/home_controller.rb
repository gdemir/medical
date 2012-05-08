# encoding: utf-8
class HomeController < ApplicationController

  def index
    session[:patient] = nil
#    flash[:info] = "Medical Servisimize Hoşgeldiniz!"
  end

  def patient_query
    session[:department] = nil
    session[:doctor] = nil
    session[:patient] = Patient.find_by_tc_and_birthday_and_birthplace(params[:tc], params[:birthday], params[:birthplace])
    redirect_to (params[:before_place] == "0") ? '/home/consult_register' : '/home/consult_query'
  end

  def department_query
    session[:department] = Patient.find(params[:department_id]) unless params[:department_id] == ""
    session[:doctor] = Doctor.find(params[:doctor_id]) unless params[:doctor_id] == ""
    redirect_to '/home/consult_register'
  end

  def consult_register
    if session[:patient] and session[:department] and session[:doctor] and params[:date]
      unless Consult.find_by_patient_id_and_doctor_id_and_date(session[:patient][:id],session[:doctor][:id],params[:date])
         consult = Consult.new({
           :patient_id => session[:patient][:id],
           :doctor_id => session[:doctor][:id],
           :date => params[:date],
         })
         consult.save
      end
    end
  end

  def consult_destroy
    if session[:patient][:id].to_s == params[:patient_id]
      consult = Consult.find_by_id_and_patient_id(params[:id], params[:patient_id])
      consult.delete
    end
    redirect_to '/home/consult_query'
  end
end
