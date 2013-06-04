
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
      :type       => params[:type] || :month,
      :params     => {},
      :center_id  =>  datacenter.id
    }
    options.reverse_merge! opts
        
    selected_month = Date.new(options[:year], options[:month],options[:day])
    if(options[:type] == "week")
      draw_week(selected_month,options)
    else
      draw_month(selected_month, options)
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

  def draw_week(selected_month, options)
    week = build_week_range(selected_month, options)
    today = Date.today
    tags = []
    tags << week_header(selected_month, options)
    content_tag(:table, :class => options[:class]) do
      tags << table_header(options)

      start_date = selected_month.beginning_of_month.beginning_of_week(options[:start_day])
      end_date   = selected_month.end_of_month.end_of_week(options[:start_day])
      days_array = Day.where( :date => start_date..end_date, :center_id => options[:center_id])

      tags << content_tag(:tbody) do
        tr = []
        ['day','night'].each do |s|
          tr << table_week(week, selected_month, today, s, days_array, options)
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

  def day_shift(shift)
    shift == 'day'
  end

  def draw_month(selected_month,options)
    range          = build_range selected_month, options
    month_array    = range.each_slice(7).to_a
    today = Date.today
    tags = []

    start_date = selected_month.beginning_of_month.beginning_of_week(options[:start_day])
    end_date   = selected_month.end_of_month.end_of_week(options[:start_day])
    days_array = Day.where( :date => start_date..end_date, :center_id => options[:center_id])

    tags << month_header(selected_month, options)

    content_tag(:table, :class => "calendar") do
      tags << table_header(options)
      tags << content_tag(:tbody) do
        tr = []
        month_array.each do |week|
          ['day','night'].each do |s|
            tr << table_week(week, selected_month, today, s,days_array,options)
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
    content_tag :div, :class => "calendar_navigation" do
      previous_month = selected_month.advance :months => -1
      next_month = selected_month.advance :months => 1
      tags = []

      tags << month_link(options[:prev_text], previous_month, options[:params], {:class => "previous-month"})
      tags << "#{I18n.t("date.month_names")[selected_month.month]} #{selected_month.year}"
      tags << month_link(options[:next_text], next_month, options[:params], {:class => "next-month"})
      tags << " ---------------- "
      tags << link_overview(options,'week',selected_month,'week')
      tags.join.html_safe
    end
  end

  def week_header(selected_week, options)
    content_tag :div, :class => "calendar_navigation" do
      previous_week = selected_week.beginning_of_week(options[:start_day]).advance :days => -1
      next_week = selected_week.end_of_week(options[:start_day]).advance :days => 1
      tags = []

      tags << week_link(options[:prev_text], previous_week, options[:params], {:class => "previous-week"})
      tags << " #{selected_week.beginning_of_week(options[:start_day]).strftime("%d/%m")}"
      tags << " - "
      tags << " #{selected_week.end_of_week(options[:start_day]).strftime("%d/%m %Y")}"
      tags << week_link(options[:next_text], next_week, options[:params], {:class => "next-week"})
      tags << " ---------------- "
      tags << link_overview(options,'month',selected_week,'month')

      tags.join.html_safe
    end
  end
  
  def month_link(text, date, params, opts={})
    link_to(text, params.merge({:month => date.month, :year => date.year}), opts)
  end

  def week_link(text, date, params, opts={})
    link_to(text, params.merge({:month => date.month, :year => date.year, :day => date.day} ), opts)
  end

  def table_week(week, selected_month, today,s,days_array,options)
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
          if (selected_month.month == day.month or options[:type] == 'week')
            if(day_shift(s))
              concat content_tag(:div,day.strftime("%d/%m")+ " denni", :class => 'date_number')
            else
              concat content_tag(:div, " nocni", :class => 'date_number')
            end

            html = []
            created_day = nil
            day_objects(day, days_array).each do |day_object|
              created_day = true
              day_object.day_collections.each do |col|
                if(s == col.shift.shift)
                  html << "<div class='operator #{col.status.name}'>"
                  html << content_tag(:div, col.user.name,  :class => 'user')
                  html << link_destroy(options,col,day)
                  html << link_confirm(options,col,day)
                  html << "</div>"
                end
              end
              html << link_reservate(options,day, s) unless day_object.has_user?(current_user)
            end.join.html_safe
            html << link_reservate(options,day, s) unless created_day

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

  def link_reservate(options,day,s)
    tags = []
    tags << "<div class='operator available'>"
    tags <<  link_to( "Volno", datacenters_day_reserve_path(options[:center_id],day.year ,day.month, day.day, s.to_s ))
    tags << "</div>"
    tags.join.html_safe
  end

  def link_destroy(options,collection, day)
    if can?(:destroy, collection)
      link_to( "Zrusit", datacenters_day_destroy_path(options[:center_id], day.year ,day.month, day.day, collection.id ))
    end
  end

  def link_confirm(options,collection, day)
    if can?(:confirm, collection)
      link_to( "Confirm", datacenters_day_confirm_path(options[:center_id], day.year ,day.month, day.day, collection.id ))
    end
  end

  def link_overview(options,name, day, overview)
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


