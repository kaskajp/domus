module ApplicationHelper
  def flash_class(type)
    case type.to_s
    when 'notice', 'success'
      'bg-green-50 text-green-800 border border-green-200'
    when 'alert', 'error'
      'bg-red-50 text-red-800 border border-red-200'
    when 'warning'
      'bg-yellow-50 text-yellow-800 border border-yellow-200'
    else
      'bg-blue-50 text-blue-800 border border-blue-200'
    end
  end
end
