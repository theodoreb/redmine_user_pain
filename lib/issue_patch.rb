require_dependency 'issue'

module RedmineUserPain
  # Patches Redmine's Issues dynamically.  Adds a +after_save+ filter.
  module IssuePatch
    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      def user_pain
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

        tracker_pain = 0
        # get enabled tracker for the current project
        @project.trackers.each do |t|
          if self.tracker_id == t.id
            pain *= @project.trackers.length - tracker_pain
          end
          tracker_pain += 1
        end

        # add type value to total pain
        pain *= IssuePriority.all.length - (IssuePriority.find_by_id(self.priority_id).position - 1)

        max_pain = @project.trackers.length * IssuePriority.all.length * likelihood_values_length
        return 100 * pain / max_pain
      end
    end    

  end
end

Issue.send(:include, RedmineUserPain::IssuePatch)
