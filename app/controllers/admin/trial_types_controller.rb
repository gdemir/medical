# encoding: utf-8
class Admin::TrialTypesController < ApplicationController

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
    trial_type = TrialType.new({
      :name => params[:name],
      :price => params[:price]
    })
    trial_type.save
    flash[:success] = "Test Tipi eklendi"
    redirect_to "/admin/trial_types/#{trial_type.id}"
  end

  def update
    trial_type = TrialType.update(params[:id], {
      :name => params[:name],
      :price => params[:price]
    })

    if trial_type.save
      flash[:success] = "Test Tipi Güncellenmiştir."
    else
      flash[:error] = "Test Tipi Güncellenemedi."
    end
    redirect_to "/admin/trial_types/#{trial_type.id}"
  end

  def destroy
    if TrialType.delete(params[:trial_type_id]) and Trial.delete_all(:trial_type_id => params[:trial_type_id])
      flash[:success] = "Kayıt Silindi"
    else
      flash[:error] = "Kayıt Silinemedi"
    end
    redirect_to '/admin/trial_types'
  end
end
