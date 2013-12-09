class CustomMailer < Devise::Mailer

	def reset_password_instructions(record, token, opts={})
		headers = { from: 'fernanda@meurio.org.br' }
  	super
  end

end