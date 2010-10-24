module RedmineUserPain
  # Patches Redmine's Issues dynamically.  Adds a +after_save+ filter.
  module IssuePatch
    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable # Send unloadable so it will not be unloaded in development
        before_save :update_user_pain_from_issue
      end
    end
    
    module InstanceMethods
      # calculate user pain from tracker, priority and custom Likelihood values
      def update_user_pain_from_issue
        # get the last custom field
        likelihood = CustomField.find_by_name("Likelihood")
        likelihood_values_length = likelihood['possible_values'].length
        pain = 1

        # add likelihood value to total pain
        self.custom_values.each do |x|
          if x.custom_field_id == likelihood.id
            pain *= likelihood_values_length - likelihood['possible_values'].index(x.value)
          end
        end

        # add type value to total pain
        pain *= Tracker.all.length - (Tracker.find_by_id(self.tracker_id).position - 1)
        pain *= IssuePriority.all.length - (IssuePriority.find_by_id(self.priority_id).position - 1)

        max_pain = Tracker.all.length * IssuePriority.all.length * likelihood_values_length
        user_pain = 100 * pain / max_pain
 
        # set user pain score
        user_pain_field = CustomField.find_by_name("User Pain")
        self.custom_values.each do |x|
          if x.custom_field_id == user_pain_field.id
            x[:value] = (user_pain).to_s
          end
        end
        
        return true
      end
    end    
  end
end
