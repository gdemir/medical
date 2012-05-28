# encoding: utf-8
class Admin::PatientsController < ApplicationController

  include ApplicationHelper
  include ImageHelper
  before_filter :require_admin

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    image = params[:image]
    patient = Patient.new({
      :tc => params[:tc],
      :file_no => params[:file_no],
      :first_name => params[:first_name],
      :last_name => params[:last_name],
      :gender => params[:gender],
      :phone => params[:phone],
      :email => params[:email],
      :birthday => params[:birthday],
      :birthplace => params[:birthplace],
      :blood_group_id => params[:blood_group_id],
      :adress => params[:adress],
      :mother_name => params[:mother_name],
      :father_name => params[:father_name],
    })

    flash[:success] = "Hasta eklendi" if patient.save

    if image and response = Image.upload('patients', patient[:id].to_s, image, false) # üzerine yazma olmasın
      if response[0] # bu yanıt iyi mi kötü mü
        patient[:image_url] = response[1]
        patient.save
      else
        flash[:error] = response[1]
      end
    end

    redirect_to "/admin/patients/#{patient[:id]}"
  end

  def update
    image = params[:image]

    patient = Patient.update(params[:id], {
      :tc => params[:tc],
      :file_no => params[:file_no],
      :first_name => params[:first_name],
      :last_name => params[:last_name],
      :gender => params[:gender],
      :phone => params[:phone],
      :email => params[:email],
      :birthday => params[:birthday],
      :birthplace => params[:birthplace],
      :blood_group_id => params[:blood_group_id],
      :adress => params[:adress],
      :mother_name => params[:mother_name],
      :father_name => params[:father_name],
    })

    if patient.save
      flash[:success] = "Hasta Güncellenmiştir"
    else
      flash[:error] = "Hasta Güncellenemedi"
    end

    if image and response = Image.upload('patients', patient[:id].to_s, image, true)
      if response[0] # bu yanıt iyi mi kötü mü
        patient[:image_url] = response[1]
        patient.save
      else
        flash[:error] = response[1]
      end
    end

    redirect_to "/admin/patients/#{patient[:id]}"
  end

  def destroy
    patient = Patient.find(params[:patient_id])
    Image.delete(patient[:image_url])

    if patient.delete
      flash[:success] = "Kayıt Silindi"
    else
      flash[:error] = "Kayıt Silinemedi"
    end

    redirect_to '/admin/patients'
  end
end
