# Hooks to attach to the Redmine Issues.
class BudgetIssueHook  < Redmine::Hook::ViewListener

  # Renders the Deliverable subject
  #
  # Context:
  # * :issue => Issue being rendered
  #
  def view_issues_show_details_bottom(context = { })
    data = "<td><b>#{l(:user_pain)}:</b></td><td>#{context[:issue].user_pain}</td>"
    return "<tr>#{data}<td></td></tr>"
  end

end
