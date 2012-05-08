# encoding: utf-8
class Admin::DepartmentsController < ApplicationController

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
    department = Department.new({
      :name => params[:name],
    })
    department.save
    flash[:success] = "İlaç eklendi"
    redirect_to "/admin/departments/#{department.id}"
  end

  def update
    department = Department.update(params[:id], {
      :name => params[:name],
    })

    if department.save
      flash[:success] = "Bölüm Güncellenmiştir."
    else
      flash[:error] = "Bölüm Güncellenemedi."
    end
    redirect_to "/admin/departments/#{department.id}"
  end

  def destroy
    if Department.delete(params[:department_id])
      flash[:success] = "Kayıt Silindi"
    else
      flash[:error] = "Kayıt Silinemedi"
    end
    redirect_to '/admin/departments'
  end
end
