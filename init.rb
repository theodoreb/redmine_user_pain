require 'redmine'

require 'dispatcher'

Dispatcher.to_prepare :redmine_redmine_user_pain do
  require_dependency 'issue'
  # Guards against including the module multiple time (like in tests)
  # and registering multiple callbacks
  unless Issue.included_modules.include? RedmineUserPain::IssuePatch
    Issue.send(:include, RedmineUserPain::IssuePatch)
  end
end

Redmine::Plugin.register :redmine_redmine_user_pain do
  name 'Redmine User Pain plugin'
  author 'Théodore Biadala'
  description 'Implement User Pain bug triage'
  version '0.0.1'
  url 'http://theodoreb.net/redmine-user-pain-triage'
  author_url 'http://theodoreb.net'
end

require 'redmine_user_pain/issue_patch'
