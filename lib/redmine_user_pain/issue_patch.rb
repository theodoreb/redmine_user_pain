module RedmineUserPain
  # Patches Redmine's Issues dynamically.  Adds a +after_save+ filter.
  module IssuePatch
    def self.included(base) # :nodoc:
      base.extend(ClassMethods)

      base.send(:include, InstanceMethods)

      # Same as typing in the class 
      base.class_eval do
        unloadable # Send unloadable so it will not be unloaded in development
        before_save :update_user_pain_from_issue
      end

    end
    
    module ClassMethods
    end
    
    module InstanceMethods
      # This will update the KanbanIssues associated to the issue
      def update_user_pain_from_issue
        pain = 1
        pain_type = 1
        pain_priority = 1
        pain_likelihood = 1
        print self.custom_field_values.inspect
        # taille liste tracker
        trackers = Tracker.all.length
        # taille liste priorité
        priorities = IssuePriority.find(:all).length
        # taille liste audience
        audience = self.available_custom_fields[0][:possible_values].length

        max_pain = trackers * priorities * audience

        # index du tracker
        Tracker.all.each { |t|
          if t.id == self.tracker_id
            pain_type = (trackers - (t.position-1))
          end
        }
        # index de la priorité
        IssuePriority.find(:all).each { |p|
          if p.id == self.priority_id
            pain_priority = (priorities - (p.position-1))
          end
        }
        # index de l'audience
        pain_likelihood = self.custom_field_values[0]['value']
        pain_likelihood = self.available_custom_fields[0][:possible_values].index(pain_likelihood)
        pain_likelihood = audience - pain_likelihood
        
        # index de l'audience 
        print pain
        pain = pain_type * pain_priority * pain_likelihood
        user_pain = 100 * pain / max_pain
        print '×'
        print user_pain

        self.custom_field_values[1][:value] = (user_pain).to_s
        #total * user_pain / 100
         
        return true
      end

    end    
  end
end
