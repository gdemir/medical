# encoding: utf-8
class Admin::TrialStoragesController < ApplicationController

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
  end

  def update
    trial_storage = TrialStorage.find(params[:id])

    if params[:sequence].to_i < 0
      flash[:error] = "Test depo sayısı 0dan küçük olamaz"
    else
      trial_storage[:sequence] = params[:sequence]
      if trial_storage.save
        flash[:success] = "Test Deposu Güncellenmiştir."
      else
        flash[:error] = "Test Deposu Güncellenemedi."
      end
    end
    redirect_to "/admin/trial_storages/#{trial_storage[:id]}"
  end
end
