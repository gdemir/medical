# encoding: utf-8
class Admin::TrialRequestsController < ApplicationController

  include ApplicationHelper
  before_filter :require_admin

  def index
  end

  def show
  end

  def new
  end

  def edit
    TrialRequest.update(params[:id], {:state => false})
  end

  def create

    if trial_request = TrialRequest.find_by_consult_id_and_trial_type_id(params[:consult_id], params[:trial_type_id])
      flash[:error] = "İstek Listesinde Bu Test Tipi Var"
    else
      # depo sayısını azalt
      trial_storage = TrialStorage.find_by_trial_type_id(params[:trial_type_id])
      if trial_storage[:sequence] > 0
        trial_storage[:sequence] = trial_storage[:sequence] - 1
        trial_storage.save

        # test isteği bulun
        trial_request = TrialRequest.new({
          :consult_id => params[:consult_id],
          :trial_type_id => params[:trial_type_id],
          :sequence => 1,
          :request_admin_id => session[:admin][:id],
          :state => params[:state],
        })
        trial_request.save

        # test tiplerini çek
        trials = Trial.find_all_by_trial_type_id(trial_request[:trial_type_id])

        # testleri çek, sonuçlar için
        trials.each do |trial|
          trial_result = TrialResult.new({
            :trial_request_id => trial_request[:id],
            :trial_id => trial[:id],
            :min_range => trial[:min_range],
            :max_range => trial[:max_range],
            :result => 0,
          })
          trial_result.save
        end
        flash[:success] = "Test İsteği Gönderildi"
      else
        flash[:error] = "Depoda bu testten kalmamış"
      end
    end
    redirect_to "/admin/consults/#{trial_request[:consult_id]}"
  end

  def update
    trial_request = TrialRequest.find(params[:id])
    trial_request[:reply_admin_id] = session[:admin][:id]

    # test sayısı güncelleme
    if params[:sequence]
      if params[:sequence].to_i < 1
        flash[:error] = "Test sayısı 1'den olamaz"
      else
        # depo sayısını azalt
        trial_storage = TrialStorage.find_by_trial_type_id(trial_request[:trial_type_id])
        if trial_storage[:sequence] + trial_request[:sequence] >= params[:sequence].to_i
          trial_storage[:sequence] = trial_storage[:sequence] + trial_request[:sequence] - params[:sequence].to_i
          trial_storage.save

          trial_request[:sequence] = params[:sequence].to_i
          trial_request.save
          flash[:success] = "Test Sayısı Güncellendi"
        else
          flash[:error] = "Bu testten kalmamış ya da yeterli kadar değil"
        end
        return redirect_to "/admin/consults/#{trial_request[:consult_id]}"
      end
    end

    # test içeriği için
    if trial_request.save
      flash[:success] = "Test Sonucu Kaydedildi."
    else
      flash[:error] = "Test Sonucu Kaydedilemedi."
    end
    return redirect_to "/admin/trial_requests/#{trial_request[:id]}"
  end

  def state
    trial_request = TrialRequest.find(params[:id])
    trial_request[:state] = params[:state]
    trial_request[:reply_admin_id] = session[:admin][:id]
    if trial_request.save
      flash[:success] = "Test Tipi Sonuçlandırıldı."
    else
      flash[:error] = "Test Tipi Sonuçlandırılamadı."
    end
    redirect_to "/admin/trial_requests/#{trial_request[:id]}"
  end

  def destroy
    trial_request = TrialRequest.find(params[:trial_request_id])
    trial_request_consult_id = trial_request[:consult_id]

    # depo sayısını arttır
    trial_storage = TrialStorage.find_by_trial_type_id(trial_request[:trial_type_id])
    trial_storage[:sequence] = trial_storage[:sequence] + trial_request[:sequence]
    trial_storage.save

    # istek silinirse faturadan da sil
    Invoice.delete_all(
      :consult_id => trial_request[:consult_id],
      :product_id => trial_request[:trial_type_id],
      :product_type => 0,
    )

    # testin sonuçlarını da sil
    TrialResult.delete_all(:trial_request_id => trial_request[:id])

    if trial_request.delete
      flash[:success] = "Kayıt Silindi"
    else
      flash[:error] = "Kayıt Silinemedi"
    end
    redirect_to "/admin/consults/#{trial_request_consult_id}"
  end
end
