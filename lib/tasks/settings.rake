namespace :db do

  namespace :settings do
    desc "Load default application settings"
    task :load => :environment do
      ActiveRecord::Base.establish_connection(Rails.env)
      if ActiveRecord::Base.connection.adapter_name.downcase == "mysql"
        ActiveRecord::Base.connection.execute("TRUNCATE settings")
      else
        ActiveRecord::Base.connection.execute("DELETE FROM settings")
      end
      settings = YAML.load_file("#{RAILS_ROOT}/config/settings.yml")
      settings.keys.each do |key|
        sql = [ "INSERT INTO settings (name, default_value) VALUES(?, ?)", key.to_s, Base64.encode64(Marshal.dump(settings[key])) ]
        sql = if Rails::VERSION::STRING < "2.3.3"
          ActiveRecord::Base.send(:sanitize_sql, sql)
        else
          ActiveRecord::Base.send(:sanitize_sql, sql, nil) # Rails 2.3.3 introduces extra "table_name" parameter.
        end
        ActiveRecord::Base.connection.execute(sql)
      end
    end
  end
end


