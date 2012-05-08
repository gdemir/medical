# encoding: utf-8
class Admin::InvoicesController < ApplicationController

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
    invoice = Invoice.new({
      :consult_id => params[:consult_id],
      :product_id => params[:product_id],
      :product_type => params[:product_type],
      :price => params[:price],
    })
    invoice.save
    flash[:success] = "Fatura eklendi"
    redirect_to "/admin/consults/#{invoice.consult_id}"
  end

  def update
    invoice = Invoice.update(params[:id], {
      :price => params[:price],
    })

    if invoice.save
      flash[:success] = "Fatura Güncellenmiştir."
    else
      flash[:error] = "Fatura Güncellenemedi."
    end
    redirect_to "/admin/consults/#{invoice.consult_id}"
  end

  def destroy
    invoice = Invoice.find(params[:invoice_id])
    invoice_consult_id = invoice.consult_id
    if invoice.delete
      flash[:success] = "Kayıt Silindi"
    else
      flash[:error] = "Kayıt Silinemedi"
    end
    redirect_to "/admin/consults/#{invoice_consult_id}"
  end
end
