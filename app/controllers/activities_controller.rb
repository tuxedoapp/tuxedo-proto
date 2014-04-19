class ActivitiesController < ApplicationController

  def new
    if vendor_signed_in?
      @activity = current_vendor.activities.new

    else
      redirect_to new_vendor_session_path
    end
  end

  def create
    @activity = current_vendor.activities.build(activities_params)
    if @activity.save
      redirect_to vendor_profile_path
    else
      flash[:alert] = "Something went wrong"
      redirect_to new_vendors_activities_path
    end
  end


  private

  def activities_params
    params.require(:activity).permit(:name, :location, :description, :price)
  end

end
