# encoding: utf-8
class Admin::ConsultsController < ApplicationController

  include ApplicationHelper
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
    redirect_to "/admin/consults"
  end

  def update
    consult = Consult.update(params[:id], {
      :department_id => params[:department_id],
      :first_name => params[:first_name],
      :last_name => params[:last_name],
    })

    if consult.save
      flash[:success] = "Başvuru Güncellenmiştir."
    else
      flash[:error] = "Başvuru Güncellenemedi."
    end
    redirect_to "/admin/consults/#{consult.id}"
  end

  def destroy
    if Consult.delete(params[:consult_id])
      flash[:success] = "Kayıt Silindi"
    else
      flash[:error] = "Kayıt Silinemedi"
    end
    redirect_to '/admin/consults/history'
  end
end
