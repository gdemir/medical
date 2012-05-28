# encoding: utf-8
class Admin::DoctorsController < ApplicationController

  include ApplicationHelper
  before_filter :require_superadmin

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    doctor = Doctor.new({
      :department_id => params[:department_id],
      :first_name => params[:first_name],
      :last_name => params[:last_name],
    })
    doctor.save
    redirect_to "/admin/doctors/#{doctor.id}"
  end

  def update
    doctor = Doctor.update(params[:id], {
      :department_id => params[:department_id],
      :first_name => params[:first_name],
      :last_name => params[:last_name],
    })

    if doctor.save
      flash[:success] = "Doktor Güncellenmiştir."
    else
      flash[:error] = "Doktor Güncellenemedi."
    end
    redirect_to "/admin/doctors/#{doctor.id}"
  end

  def destroy
    if Doctor.delete(params[:doctor_id])
      flash[:success] = "Kayıt Silindi"
    else
      flash[:error] = "Kayıt Silinemedi"
    end
    redirect_to '/admin/doctors'
  end
end
