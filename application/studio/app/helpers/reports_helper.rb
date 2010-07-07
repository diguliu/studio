module ReportsHelper

  def reports_list(reports)
    result = "<table>"
    reports.each do |report|
      result << "<tr>"
      result << "<td>"+report.responsible.name+"</td>"
      result << "<td>"+report.total_price.to_s+"</td>"
      result << "</tr>" 
    end
    result << "</table>"
  end
end
