class ResumeMailer < ApplicationMailer

	def send_resume(callback)
		@callback = callback
		attachments['resume.pdf'] = @callback.resume
		mail(to: 'anuar.dikhanov@gmail.com', subject: 'New Callback')
	end

end
