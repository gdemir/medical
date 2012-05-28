# encoding: utf-8
class Admin::TrialsController < ApplicationController

  include ApplicationHelper
  before_filter :require_admin

  def index
  end

  def show
  end

  def new
    @trial_type_id = params[:trial_type_id]
  end

  def edit
  end

  def create
    trial = Trial.new({
      :trial_type_id => params[:trial_type_id],
      :name => params[:name],
      :min_range => params[:min_range],
      :max_range => params[:max_range],
      :units => params[:units]
    })
    trial.save
    flash[:success] = "Test eklendi"
    redirect_to "/admin/trial_types/#{trial[:trial_type_id]}"
  end

  def update
    trial = Trial.update(params[:id], {
      :name => params[:name],
      :min_range => params[:min_range],
      :max_range => params[:max_range],
      :units => params[:units]
    })

    if trial.save
      flash[:success] = "Test Güncellenmiştir."
    else
      flash[:error] = "Test Güncellenemedi."
    end
    redirect_to "/admin/trial_types/#{trial[:trial_type_id]}/edit"
  end

  def destroy
    trial = Trial.find(params[:trial_id])
    trial_type_id = trial[:trial_type_id]

    if trial.delete
      flash[:success] = "Kayıt Silindi"
    else
      flash[:error] = "Kayıt Silinemedi"
    end
    redirect_to "/admin/trial_types/#{trial_type_id}/edit"
  end
end
