class RatesController < ApplicationController
  before_filter :require_user

  def create
    @rateable = find_rateable
    @rate = @rateable.rates.build(params[:rate]) if @rateable
    @rate.user = current_user if current_user
    if @rateable && @rate.save
      flash[:notice] = "Successfully rated."
      redirect_to @rateable
    else
      flash[:notice] = "Couldn't rate that item."
      redirect_to @rateable
    end
  end

  private

  def find_rateable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        begin
          return $1.classify.constantize.find(value)
        rescue
          nil
        end
      end
    end
    nil
  end

end
