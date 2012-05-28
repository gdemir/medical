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
    invoice = Invoice.find_by_consult_id_and_product_id_and_product_type(params[:consult_id],
                                                                         params[:product_id],
                                                                         params[:product_type])
    if invoice
      flash[:error] = "Faturada bu ürün zaten var"
    else
      invoice = Invoice.new({
        :consult_id => params[:consult_id],
        :product_id => params[:product_id],
        :product_type => params[:product_type],
        :price => params[:price],
        :sequence => params[:sequence],
      })
      invoice.save

      flash[:success] = "Faturaya Eklendi"
    end
    redirect_to "/admin/consults/#{invoice[:consult_id]}"
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
    redirect_to "/admin/consults/#{invoice[:consult_id]}"
  end

  def destroy
    invoice = Invoice.find(params[:invoice_id])
    invoice_consult_id = invoice[:consult_id]

    if invoice.delete
      flash[:success] = "Kayıt Faturadan Silindi"
    else
      flash[:error] = "Kayıt Faturadan Silinemedi"
    end
    redirect_to "/admin/consults/#{invoice_consult_id}"
  end
end
