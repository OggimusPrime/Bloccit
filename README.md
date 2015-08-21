##Raddit:

A Reddit replica to teach the fundamentals of web development and Rails.

https://ryanhaase-raddit.herokuapp.com/

Made with my mentor at <a href='http://bloc.io'>Bloc.io</a>.

###Setup:

1. This app uses <a href='https://github.com/laserlemon/figaro'>figaro</a> to manage environment variables which are store in application.yml

2. Email notifications are handled through <a href='https://sendgrid.com/'>SendGrid</a> add on email service.

3. Amazon S3 is used for image storage.  Be sure to create separate buckets for development and production.

4. Be sure to store the security keys in config/application.yml and that application.yml is in .gitignore prior to committing those changes.  
