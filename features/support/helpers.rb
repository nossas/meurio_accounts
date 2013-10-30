def to_url string
  return new_user_session_path(redirect_url: "http://127.0.0.1/pdp")  if string == "the login page comming from Panela de Pressão"
  return new_user_session_path                                        if string == "the login page"
  return "/pdp"                                                       if string == "Panela de Pressão"
  return "/users/#{@user.id}"                                         if string == "my profile page"
end

def to_element string
  return 'user_email'                         if string == "the login email"
  return 'user_password'                      if string == "the login password"
  return 'form#new_user input[type="submit"]' if string == "the login form"
  return '.flash.alert'                       if string == "the login form errors"
end

def to_text string
  return I18n.t("devise.failure.not_found_in_database") if string == "the login form errors"
end
