class Admin::ReportsController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_report, except: [:index, :destroy_selected]

  def index
    @reports = Report.order(created_at: :desc).page(params[:page])
  end

  def show
  end

  def update
    if @report.update(report_params)
      redirect_to admin_report_path(@report), notice: "ステータスが更新されました"
    else
      render :show
    end
  end

  def destroy
    @report.destroy
    redirect_to admin_reports_path, notice: "通報が削除されました"
  end

  def destroy_selected
    selected_reports = params[:selected_reports]
    if selected_reports.blank?
      redirect_to admin_reports_path, alert: "通報を選択してください"
    else
      Report.where(id: selected_reports).destroy_all
      redirect_to admin_reports_path, notice: "選択された通報が削除されました"
    end
  end

  private

  def ensure_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:status)
  end
end
