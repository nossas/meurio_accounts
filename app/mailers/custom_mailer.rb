class CustomMailer < ActionMailer::Base

	def reset_password_instructions(record, token, opts={})
		headers = { from: 'fernanda@meurio.org.br' }
  	super
  end

end