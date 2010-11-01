require 'redmine'

require 'issue_patch'
require 'query_patch'
require 'user_pain_issue_hook'

Redmine::Plugin.register :redmine_redmine_user_pain do
  name 'Redmine User Pain plugin'
  author 'Théodore Biadala'
  description 'Implement User Pain bug triage'
  version '0.0.1'
  url 'http://theodoreb.net/redmine-user-pain-triage'
  author_url 'http://theodoreb.net'
end

