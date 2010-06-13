module CalendarHelper
  def month_link(month_date)
    link_to(I18n.localize(month_date, :format => "%B"), {:month => month_date.month, :year => month_date.year})
  end
  
  # custom options for this calendar
  def event_calendar_opts
    { 
      :year => @year,
      :month => @month,
      :event_strips => @event_strips,
      :month_name_text => I18n.localize(@shown_month, :format => "%B %Y"),
      :previous_month_text => "<< " + month_link(@shown_month.last_month),
      :next_month_text => month_link(@shown_month.next_month) + " >>",
      :height => 400,
    }
  end

  def event_calendar
    # args is an argument hash containing :event, :day, and :options
    calendar event_calendar_opts do |args|
      event = args[:event]
      if event.agenda_id
        %(<a href="/agendas/#{event.agenda_id}" title="#{h(event.name)}">#{h(event.name)}</a>)
      elsif event.external_rent_id
        %(<a href="/clients/show_rent/#{event.external_rent_id}" title="#{h(event.name)}">#{h(event.name)}</a>)
      end
    end
  end
end
