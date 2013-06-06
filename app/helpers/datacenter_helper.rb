
module DatacenterHelper

  def datacenter(datacenter, options={})

    opts = {
      :year       => (params[:year] || Time.zone.now.year).to_i,
      :month      => (params[:month] || Time.zone.now.month).to_i,
      :day       => (params[:day] || Time.zone.now.day).to_i,
      :prev_text  => raw(" &laquo; "),
      :next_text  => raw(" &raquo; "),
      :start_day  => :monday,
      :class      => "calendar",
      :type       => params[:type] || "month",
      :params     => {},
      :center_id  =>  datacenter.id
    }
    options.reverse_merge! opts
        
    selected_date = Date.new(options[:year], options[:month],options[:day])
    if(options[:type] == "week")
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
      tags << link_overview(options, I18n.t("mydate.week"),selected_date,'week')
      tags.join.html_safe
    end
  end

  def week_header(selected_week, options)
    content_tag :div, :class => "calendar_navigation" do
      previous_week = selected_week.beginning_of_week(options[:start_day]).advance :days => -1
      next_week = selected_week.end_of_week(options[:start_day]).advance :days => 1
      tags = []

      tags << link_week(options[:prev_text], previous_week, options[:params], {:class => "previous-week"})
      tags << " #{selected_week.beginning_of_week(options[:start_day]).strftime("%d/%m")}"
      tags << " - "
      tags << " #{selected_week.end_of_week(options[:start_day]).strftime("%d/%m %Y")}"
      tags << link_week(options[:next_text], next_week, options[:params], {:class => "next-week"})
      tags << " ---------------- "
      tags << link_overview(options,I18n.t("mydate.month"),selected_week,'month')

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
          if (selected_date.month == day.month or options[:type] == 'week')
            if(day_shift(s))
              concat content_tag(:div,day.strftime("%d/%m")+ " denni", :class => 'date_number')
            else
              concat content_tag(:div, " nocni", :class => 'date_number')
            end

            html = []
    
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

            if !day_shift(s)
              html << link_admin_reserv(options,day)
            end

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
    if can?(:manage,:day_reserve)
      tags = []
      tags << "<div class='operator available'>"
      tags <<  link_to( "Volno", datacenters_day_reserve_path(options[:center_id],day.year ,day.month, day.day, s.to_s ))
      tags << "</div>"
      tags.join.html_safe
    end
  end

  def link_destroy(options, col_id, day)
    #to do col_id is not object any more
    if can?(:destroy, DayCollection.find(col_id))
      link_to( "Zrusit", datacenters_day_destroy_path(options[:center_id], day.year ,day.month, day.day, col_id ))
    end
  end

  def link_confirm(options, col_id, day)
    if can?(:day_confirm, DayCollection.find(col_id))
      link_to( "Confirm", datacenters_day_confirm_path(options[:center_id], day.year ,day.month, day.day, col_id  ))
    end
  end

  def link_overview(options, name, day, overview)
    link_to("#{name}", datacenters_view_path(options[:center_id],:year => day.year , :month => day.month, :day => day.day, :view => overview ))
  end

  def link_admin_reserv(options,day)
    if can?(:manage, :multiple)
      html =[]
      html << "<div class='operator available admin'>"
      html << link_to( "Admin", datacenters_admin_manage_days_path(options[:center_id], day.year ,day.month, day.day ))
      html << "</div>"
      html.join.html_safe
    end
  end
end


