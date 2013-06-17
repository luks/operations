
module DatacenterHelper

  def datacenter(datacenter, options={})

    opts = {
      :year       => (params[:year] || Time.zone.now.year).to_i,
      :month      => (params[:month] || Time.zone.now.month).to_i,
      :day        => (params[:day] || Time.zone.now.day).to_i,
      :prev_text  => raw(" &laquo; "),
      :next_text  => raw(" &raquo; "),
      :start_day  => :monday,
      :class      => "calendar",
      :viewport       => options[:type],
      :params     => {},
      :center_id  =>  datacenter.id
    }

    options.reverse_merge! opts
        
    selected_date = Date.new(options[:year], options[:month],options[:day])
    if(options[:viewport] == "week")
      draw_week(selected_date,options)
    else
      draw_month(selected_date, options)
    end
  end


  private

  def build_week_range(selected_date, options)
    start_date = selected_date.beginning_of_week(options[:start_day])
    end_date   = selected_date.end_of_week(options[:start_day])
    (start_date..end_date).to_a
  end

  def build_range(selected_date, options)
    start_date = selected_date.beginning_of_month.beginning_of_week(options[:start_day])
    end_date   = selected_date.end_of_month.end_of_week(options[:start_day])
    (start_date..end_date).to_a
  end

  def draw_month(selected_date,options)

    range          = build_range selected_date, options
    month_array    = range.each_slice(7).to_a
    today = Date.today
    tags = []

    start_date = selected_date.beginning_of_month
    end_date   = selected_date.end_of_month
    

    days_array = Day.day_collection_optimalised(start_date, end_date)
    day_collection = DayCollection.optimalised(start_date, end_date)
    
    @day_collections_hash = day_collection.inject({}) { |h, i| h[i.id] = i; h }

    tags << month_header(selected_date, options)

    content_tag(:table, :class => "calendar") do
      tags << table_header(options)
      tags << content_tag(:tbody) do
        tr = []
        month_array.each do |week|
          ['day','night'].each do |s|
            tr << table_week(week, selected_date, today, s,days_array,options)
          end.join.html_safe
        end.join.html_safe
        tr.join.html_safe
      end
      tags.join.html_safe
    end
  end

  def draw_week(selected_date, options)

    week = build_week_range(selected_date, options)
    today = Date.today
    tags = []
    tags << week_header(selected_date, options)
    content_tag(:table, :class => options[:class]) do
      
      tags << table_header(options)

      start_date = selected_date.beginning_of_week(options[:start_day])
      end_date   = selected_date.end_of_week(options[:start_day])

      days_array = Day.day_collection_optimalised(start_date, end_date)
      day_collection = DayCollection.optimalised(start_date, end_date)

      @day_collections_hash = day_collection.inject({}) { |h, i| h[i.id] = i; h }


      tags << content_tag(:tbody) do
        tr = []
        ['day','night'].each do |s|
          tr << table_week(week, selected_date, today, s, days_array, options)
        end.join.html_safe
        tr.join.html_safe
      end
      tags.join.html_safe
    end
  end

  def day_objects(day, days_array)
    days_array.select do |e|
      e.date == day
    end
  end

  def user_ocupied?(day_array)
    day_array.detect { |day| day.user_id == current_user.id }
  end
  
  def day_shift(shift)
    shift == 'day'
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

  def month_header(selected_date, options)
    content_tag :div, :class => "calendar_navigation" do
      previous_month = selected_date.advance :months => -1
      next_month = selected_date.advance :months => 1
      tags = []

      tags << link_month(options[:prev_text], previous_month, options[:params], {:class => "previous-month"})
      tags << "#{I18n.t("date.month_names")[selected_date.month]} #{selected_date.year}"
      tags << link_month(options[:next_text], next_month, options[:params], {:class => "next-month"})
      tags << " ---------------- "
      tags << link_viewport(options, I18n.t("mydate.week"),selected_date,'week')
      tags.join.html_safe
    end
  end

  def week_header(selected_date, options)
    content_tag :div, :class => "calendar_navigation" do
      previous_week = selected_date.beginning_of_week(options[:start_day]).advance :days => -1
      next_week = selected_date.end_of_week(options[:start_day]).advance :days => 1
      tags = []

      tags << link_week(options[:prev_text], previous_week, options[:params], {:class => "previous-week"})
      tags << " #{selected_date.beginning_of_week(options[:start_day]).strftime("%d/%m")}"
      tags << " - "
      tags << " #{selected_date.end_of_week(options[:start_day]).strftime("%d/%m %Y")}"
      tags << link_week(options[:next_text], next_week, options[:params], {:class => "next-week"})
      tags << " ---------------- "
      tags << link_viewport(options,I18n.t("mydate.month"),selected_date,'month')

      tags.join.html_safe
    end
  end
  


  def table_week(week, selected_date, today,s,days_array,options)
    tr = []

    tr << content_tag(:tr, :class => s) do
      td = [] 

      week.each do |day|
        td_class = ["week_day"]
        td_class << "today" if today == day
        td_class << "not-current-month" if selected_date.month != day.month
        td_class << "past" if today > day
        td_class << "future" if today < day

        td << content_tag(:td, :class => td_class.join(" ")) do
          if (selected_date.month == day.month or options[:viewport] == 'week')
            if(day_shift(s))
              concat content_tag(:div, day.strftime("%d/%m") + " " +  I18n.t("calendar.actions.day") , :class => 'operator date_number')
            else
              concat content_tag(:div, I18n.t("calendar.actions.night"), :class => 'date_number')
            end

            html = []
            if day_shift(s)
              html << link_admin_reserv(options,day)
            end
            day_array = day_objects(day, days_array)
            user_ocupied = user_ocupied?(day_array)

            day_array.each do |collection| 
                created_day = true 
                if collection.center_id == options[:center_id] 
                  if(s == collection.shift)
                    html << "<div class='operator #{collection.status}'>"
                    html << content_tag(:div, collection.user,  :class => 'user')
                    html << link_destroy(options,collection.col_id,day) 
                    html << link_confirm(options,collection.col_id,day)
                    html << "</div>"
                  end
                end
            end.join.html_safe
            html << link_reservate(options,day, s) unless user_ocupied

            concat html.join.html_safe
          end

        end
      end.join.html_safe
      td.join.html_safe
    end
  end
  



  def link_month(text, date, params, opts={})
    link_to(text, params.merge({:month => date.month, :year => date.year}), opts)
  end

  def link_week(text, date, params, opts={})
    link_to(text, params.merge({:month => date.month, :year => date.year, :day => date.day} ), opts)
  end
  
  def link_reservate(options,day,s)
    if can?(:day_reserve, Datacenter) and today_or_younger(day,s)
      tags = []
      tags << "<div class='operator available' id='#{s+day.to_s}'>"
      tags <<  link_to(I18n.t("calendar.actions.reservate_day"), 
        datacenters_day_reserve_path(options[:center_id],day.year ,day.month, day.day, s.to_s ), 
        :method => :post)
      tags << "</div>"
      tags.join.html_safe
    end
  end

  def link_destroy(options, col_id, day)
    if can?(:destroy, @day_collections_hash[col_id]) and today_or_younger(day,@day_collections_hash[col_id].shift)
      link_to( I18n.t("calendar.actions.delete_day"), 
        datacenters_day_destroy_path(options[:center_id], day.year ,day.month, day.day, col_id ), 
        :method => :post)
    end
  end

  def link_confirm(options, col_id, day)
    if can?(:day_confirm, @day_collections_hash[col_id]) and today_or_younger(day)
      link_to( I18n.t("calendar.actions.confirm_day"), 
        datacenters_day_confirm_path(options[:center_id], day.year ,day.month, day.day, col_id  ), 
        :method => :post)
    end
  end

  def link_viewport(options, name, day, overview)
    link_to("#{name}", datacenters_viewport_path(options[:center_id],:year => day.year , :month => day.month, :day => day.day, :viewport => overview ))
  end

  def link_admin_reserv(options,day)
    if can?(:admin_manage_days, Datacenter) and today_or_younger(day,nil)
      html =[]
      html << "<div class='operator available admin'>"
      html << link_to( I18n.t("calendar.actions.administrate"), datacenters_admin_manage_days_path(options[:center_id], day.year ,day.month, day.day ))
      html << "</div>"
      html.join.html_safe
    end
  end
  
  def today_or_younger(date,s)
    if Date.today == date 
      if s == 'day'
        DateTime.now > DateTime.strptime('08:00', '%H:%M')
      elsif s == 'night' 
        DateTime.now > DateTime.strptime('20:00', '%H:%M')    
      else
        Date.today <= date
      end  
    else  
      Date.today <= date
    end
  end   
    
end


