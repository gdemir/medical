# encoding: utf-8
class Admin::TrialResultsController < ApplicationController

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
    trial_result = TrialResult.update(params[:id], {
      :min_range => params[:min_range],
      :result => params[:result],
      :max_range => params[:max_range],
    })

    if trial_result.save
      flash[:success] = "Test Sonucu Güncellenmiştir."
    else
      flash[:error] = "Test Sonucu Güncellenemedi."
    end
    redirect_to "/admin/trial_requests/#{trial_result[:trial_request_id]}/edit"
  end
end
