module ApplicationHelper

  
  def prepare_flash_message(flash_type, flash_value)
    prepared_message = { :class => "alert-warning", :heading => "", :message => ""}
    
    case flash_type
      when :alert
        prepared_message[:class] = "alert-warning"
      when :error
        prepared_message[:class] = "alert-error"
      when :notice
        prepared_message[:class] = "alert-info"
      when :success
        prepared_message[:class] = "alert-success"
      # Defaults to initialized value above
      # else
      #   type.to_s
    end

    if flash_value.class == Hash
      prepared_message[:heading] = flash_value[:heading]
      prepared_message[:message] = flash_value[:message]
    else
      prepared_message[:message] = flash_value
    end
    
    return prepared_message
    
  end
  
end