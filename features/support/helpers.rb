def to_url string
  return new_user_session_path(redirect_url: "http://127.0.0.1/pdp")      if string == "the login page comming from Panela de Pressão"
  return new_user_session_path                                            if string == "the login page"
  return new_user_registration_path(redirect_url: "http://127.0.0.1/pdp") if string == "the register page comming from Panela de Pressão"
  return new_user_registration_path                                       if string == "the register page"
  return "/pdp"                                                           if string == "Panela de Pressão"
  return "/users/#{@user.id}"                                             if string == "my profile page"
  return edit_user_path(@current_user)                                    if string == "the edit page of my profile"
  raise "I don't know what #{string} means"
end

def to_element string
  return 'user_email'                         if string == "the login email"
  return 'user_password'                      if string == "the login password"
  return 'form#new_user input[type="submit"]' if string == "the login form"
  return '.flash.alert'                       if string == "the login form errors"
  return 'user_first_name'                    if string == "the register first name"
  return 'user_last_name'                     if string == "the register last name"
  return 'user_email'                         if string == "the register email"
  return 'user_password'                      if string == "the register password"
  return 'form#new_user input[type="submit"]' if string == "the register form"
  return '.flash.alert'                       if string == "an error message"
end

def to_text string
  return I18n.t("devise.failure.not_found_in_database") if string == "the login form errors"
end
