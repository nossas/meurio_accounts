class CustomMailer < Devise::Mailer

	def reset_password_instructions(record, token, opts={})
		opts[:from] = 'Fernanda Whately <fernanda@minhascidades.org.br>'
  	super
  end
end
