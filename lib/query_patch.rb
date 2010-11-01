require_dependency 'query'

module QueryPatch
  def self.included(base)
    base.extend(ClassMethods)

    # Same as typing in the class 
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development
      base.add_available_column(QueryColumn.new(:user_pain, {
        :sortable => true
      }))
        
      alias_method :redmine_available_filters, :available_filters
    end
  
  end
  
  module ClassMethods
    def available_columns=(v)
      self.available_columns = (v)
    end

    def add_available_column(column)
      self.available_columns << (column)
    end
  end
     
end

# Add module to Query
Query.send(:include, QueryPatch)
