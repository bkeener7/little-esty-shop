class MerchantDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.bulk_discounts.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    new_discount = @merchant.bulk_discounts.new(bulk_discount_params)

    if new_discount.save
      flash[:message] = 'Discount successfully created'
      redirect_to merchant_discounts_path(@merchant)
    else
      flash[:error] = 'Required content missing or invalid'
      redirect_to new_merchant_discount_path(@merchant)
    end
  end

  private

  def bulk_discount_params
    params.permit(:percentage_discount, :quantity_threshold)
  end
end
