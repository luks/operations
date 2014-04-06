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

  def self.update_fast(users,params)
    puts params
      self.transaction do
        params.map do |k,r|
          if(users.include? r[:user_id])
            sql_u = ActiveRecord::Base.send(:sanitize_sql_array,
              ["UPDATE day_collections SET status_id = #{r[:status_id]},shift_id = #{r[:shift_id]},center_id = #{r[:center_id]}
              WHERE day_collections.id = #{r[:id]}"]
            )
                Thread.new do
                  day_collection = DayCollection.find(r[:id])
                  fake = DayCollection.new(r)
                  Notifier.admin_update_shift(day_collection, fake).deliver unless fake.identical? day_collection
                  ActiveRecord::Base.connection.close
                end
                DayCollection.connection.execute(sql_u)
          else
            sql_d = ActiveRecord::Base.send(:sanitize_sql_array,
              ["DELETE FROM day_collections WHERE day_collections.id = #{r[:id]}"]
            )
                Thread.new do
                  Notifier.admin_delete_shift(DayCollection.find(r[:id])).deliver
                  ActiveRecord::Base.connection.close
                end
            DayCollection.connection.execute(sql_d)

          end
        end
      end
  end

  def self.create_fast(users,params)
      self.transaction do
        @collections = []
        params.map do |r|
          if(users.include? r[:user_id])
            sql = ActiveRecord::Base.send(:sanitize_sql_array,
             ["INSERT INTO day_collections
             (day_id, shift_id, status_id, user_id, center_id) VALUES
             (#{r[:day_id]}, #{r[:shift_id]}, #{r[:status_id]},#{r[:user_id]},#{r[:center_id]})"]
            )
            DayCollection.connection.execute(sql)
            @collections << DayCollection.where(:day_id => r[:day_id],:user_id => r[:user_id]).first 
          end
        end
      end  
        Thread.new do  
          @collections.each do |collection|        
            Notifier.admin_create_shift(collection).deliver
            ActiveRecord::Base.connection.close
          end
        end
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

  def diference(other)
    self.attributes.diff(other.attributes)   
  end  
end