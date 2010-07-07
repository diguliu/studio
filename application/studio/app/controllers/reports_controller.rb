class ReportsController < ApplicationController
  def index
    report_filters = !params.blank? ? params[:filters] : {}
    items = !params.blank? ?
      if params[:classification == "full"]
        Agenda.find(:all)+ExternalRent.find(:all)
      elsif params[:classification == "services"]
        Agenda.find(:all)
      elsif params[:classification == "rents"]
        ExternalRent.find(:all)
      else
        []
      end : []
    @reports = filter_reports(Agenda.find(:all) + ExternalRent.find(:all), report_filters)
  end

  def filter_reports(reports = [], filters = {})
    if filters
      reports.delete_if{|report| report.class == "ExternalRent"}if filters[:classification] && filters[:classification] == "services"
      reports.delete_if{|report| report.class == "Agenda"} if filters[:classification] && filters[:classification] == "rents"
      reports.delete_if{|report| report.start < Date.strptime(filters[:start_date], "%b %d, %Y")} if !filters[:start_date].blank?
      reports.delete_if{|report| report.start > Date.strptime(filters[:end_date], "%b %d, %Y")} if !filters[:end_date].blank?
      reports.delete_if{|report| report.band != filters[:band]} if filters[:band]
      reports.delete_if{|report| report.client != filters[:client]} if filters[:client]
    end
    reports
  end
end
