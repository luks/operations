class DayCollection < ActiveRecord::Base
  attr_accessible :shift_id, :status_id, :user_id, :day_id, :center_id
  belongs_to :user
  belongs_to :status
  belongs_to :shift
  belongs_to :day
  belongs_to :datacenter, :foreign_key => :center_id

  
  def self.optimalised(from, to)
    self.find_by_sql("SELECT day_collections.* FROM day_collections 
                      LEFT JOIN days ON day_collections.day_id = days.id 
                      WHERE  (days.date BETWEEN '#{from}' AND '#{to}')")
  end

  def self.update_fast(r)
    self.connection.execute(sanitize_sql(
              ["UPDATE day_collections SET status_id = #{r[:status_id]},shift_id = #{r[:shift_id]},center_id = #{r[:center_id]}
              WHERE day_collections.id = #{r[:id]}"]
            ))
  end

  def self.create_fast(r)
    self.connection.execute(sanitize_sql(["INSERT INTO day_collections
             (day_id, shift_id, status_id, user_id, center_id) VALUES
             (#{r[:day_id]}, #{r[:shift_id]}, #{r[:status_id]},#{r[:user_id]},#{r[:center_id]})"]))
  end  

  def self.delete_fast(r)
    self.connection.execute(sanitize_sql(["DELETE FROM day_collections WHERE day_collections.id = #{r[:id]}"]))
  end  

  def self.identical_ignore_list
    [:id]
  end

  def identical?(other)
    self.attributes.except(*self.class.identical_ignore_list.map(&:to_s)) ==
    other.attributes.except(*self.class.identical_ignore_list.map(&:to_s))
  end
end
