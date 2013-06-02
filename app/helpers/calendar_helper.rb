
module CalendarHelper

  def calendar(events,options={})

    opts = {
      :year       => (params[:year] || Time.zone.now.year).to_i,
      :month      => (params[:month] || Time.zone.now.month).to_i,
      :day       => (params[:day] || Time.zone.now.day).to_i,
      :prev_text  => raw("&laquo;"),
      :next_text  => raw("&raquo;"),
      :start_day  => :monday,
      :class      => "calendar",
      :type       => params[:type] || :month,
      :params     => {}
    }
    options.reverse_merge! opts
    events       ||= []
    selected_month = Date.new(options[:year], options[:month],options[:day])
    if(options[:type] == "week")
      draw_week(events,selected_month,options)
    else
      draw_month(events,selected_month, options)
    end
  end


  private

  def build_week_range(selected_month, options)
    start_date = selected_month.beginning_of_week(options[:start_day])
    end_date   = selected_month.end_of_week(options[:start_day])
    (start_date..end_date).to_a
  end

  def build_range(selected_month, options)
    start_date = selected_month.beginning_of_month.beginning_of_week(options[:start_day])
    end_date   = selected_month.end_of_month.end_of_week(options[:start_day])
    (start_date..end_date).to_a
  end

  def draw_week(events, selected_month, options)
    week = build_week_range(selected_month, options)
    today = Date.today
    tags = []
    tags << week_header(selected_month, options)
    content_tag(:table, :class => options[:class]) do
      tags << table_header(options)

      tags << content_tag(:tbody) do
        tr = []
        ['day','night'].each do |s|
          tr << table_week(week, selected_month, today, s,events)
        end.join.html_safe
        tr.join.html_safe
      end
      tags.join.html_safe
    end
  end

  def day_objects(day, events)
    events.select do |e|
      e.date == day
    end
  end

  def day_shift(shift)
    shift == 'day'
  end

  def draw_month(events,selected_month,options)
    range          = build_range selected_month, options
    month_array    = range.each_slice(7).to_a
    today = Date.today
    tags = []
    tags << month_header(selected_month, options)
    content_tag(:table, :class => "calendar") do
      tags << table_header(options)
      tags << content_tag(:tbody) do
        tr = []
        month_array.each do |week|
          ['day','night'].each do |s|
            tr << table_week(week, selected_month, today, s,events)
          end.join.html_safe
        end.join.html_safe
        tr.join.html_safe
      end
      tags.join.html_safe
    end
  end
 
  def table_header(options)
    day_names = I18n.t("date.abbr_day_names")
    day_names = day_names.rotate((Date::DAYS_INTO_WEEK[options[:start_day]] + 1) % 7)
    tags = []
    tags << content_tag(:thead) do
      content_tag(:tr) do
        th = []
        day_names.each do |name|
          th << content_tag(:th , :class => 'dayName') do |div|
            content_tag(:div, name.to_s)
          end
        end.join.html_safe
        th.join.html_safe
      end
    end
  end

  def month_header(selected_month, options)
    content_tag :h2 do
      previous_month = selected_month.advance :months => -1
      next_month = selected_month.advance :months => 1
      tags = []

      tags << month_link(options[:prev_text], previous_month, options[:params], {:class => "previous-month"})
      tags << "#{I18n.t("date.month_names")[selected_month.month]} #{selected_month.year}"
      tags << month_link(options[:next_text], next_month, options[:params], {:class => "next-month"})

      tags.join.html_safe
    end
  end

  def week_header(selected_week, options)
    content_tag :h2 do
      previous_week = selected_week.beginning_of_week(options[:start_day]).advance :days => -1
      next_week = selected_week.end_of_week(options[:start_day]).advance :days => 1
      tags = []

      tags << week_link(options[:prev_text], previous_week, options[:params], {:class => "previous-week"})
      tags << "#{I18n.t("date.month_names")[selected_week.month]} #{selected_week.year}"
      tags << week_link(options[:next_text], next_week, options[:params], {:class => "next-week"})

      tags.join.html_safe
    end
  end
  
  def month_link(text, date, params, opts={})
    link_to(text, params.merge({:month => date.month, :year => date.year}), opts)
  end

  def week_link(text, date, params, opts={})
    link_to(text, params.merge({:month => date.month, :year => date.year, :day => date.day} ), opts)
  end

  def table_week(week, selected_month, today,s,events)
    tr = []
    tr << content_tag(:tr, :class => s) do
      td = []
      
      week.each do |day|
        td_class = ["week_day"]
        td_class << "today" if today == day
        td_class << "not-current-month" if selected_month.month != day.month
        td_class << "past" if today > day
        td_class << "future" if today < day

        td << content_tag(:td, :class => td_class.join(" ")) do

          if(day_shift(s))
            concat content_tag(:div,day.strftime("%d/%m/%Y"), :class => 'date_number')
          else
            concat content_tag(:div,"nocni (20:00-08:00)", :class => 'date_number')
          end

        
          day_objects(day, events).each do |day_object|
            html = []
            day_object.day_collections.each do |shift|
              if(s == shift.shift.name)
                html << "<div class='operator #{shift.status.name}'>"
                html << content_tag(:div, shift.user.name,  :class => 'user')
                html << "</div>"
              end
            end
            concat html.join.html_safe
          end.join.html_safe
         
          
          html = []
          html << "<div class='operator available'>"
          html << link_to( "Volno", day_collection_day_path(day.year ,day.month, day.day, s.to_s ))
          html << link_to( "Admin", day_collection_admin_day_path(day.year ,day.month, day.day, s.to_s ))
          html << "</div>"
          concat html.join.html_safe
          
       
        end
      end.join.html_safe
      td.join.html_safe
    end

  end
end


