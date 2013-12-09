class CustomMailer < Devise::Mailer

	def reset_password_instructions(record, token, opts={})
		opts[:from] = 'Meu Rio <fernanda@meurio.org.br>'
  	super
  end

end