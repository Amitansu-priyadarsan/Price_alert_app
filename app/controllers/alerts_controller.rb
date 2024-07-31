class AlertsController < ApplicationController
  before_action :authenticate_user!

  def create
    alert = current_user.alerts.build(alert_params)
    if alert.save
      Rails.logger.info "Created alert with ID: #{alert.id}"
      render json: { alert: alert }, status: :created
    else
      render json: { errors: alert.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      # Find the alert by its ID belonging to the current user
      alert = current_user.alerts.find(params[:id])
      if alert.destroy
        render json: { message: 'Alert deleted' }, status: :ok
      else
        render json: { errors: 'Failed to delete alert' }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Alert not found' }, status: :not_found
    end
  end

  def index
    alerts = current_user.alerts.where(status: params[:status]).paginate(page: params[:page], per_page: 10)
    render json: { alerts: alerts }
  end

  private

  def alert_params
    params.require(:alert).permit(:cryptocurrency, :target_price, :status)
  end
end
