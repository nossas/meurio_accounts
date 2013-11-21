module ApplicationHelper
  
  def values_for_local_availability
    User.values_for_availability.select { |v| v.to_s.start_with? 'local' }
  end

  def values_for_remote_availability
    User.values_for_availability.select { |v| v.to_s.start_with? 'remote' }
  end

  def slice_type value
    value.to_s.split('_').first
  end

  def slice_day value
    value.to_s.split('_').at(1)
  end

  def slice_shift value
    value.to_s.split('_').last
  end
end
