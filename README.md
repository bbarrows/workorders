Following:

https://www.railstutorial.org/book/user_microposts


Work Order should be called Job Ticket

User
	Empoyee #

Job Ticket
	Date - Present to Two months back
	Work Order #
	Job Code
	Employee #   Auto Populate this from the user account
	Quantity



Entry
	Start time
	End time



rails generate scaffold Ticket date:date work_order:string job_code:string quantity:integer user:references
rails generate scaffold Entry start:datetime end:datetime ticket:references
rake db:migrate





Make sure all entry times ACROSS JOB TICKETS for the SAME USER do not conflict

Add feature to pull up all Job Tickets and Entry with end time in set 24 hour range

Start time and End time are filled in and valid time





INSTALL:

use rvm
Rails needs ruby 2.0 >

Install RVM

Tnstall ruby 2.2

Install passenger/nginx
https://www.digitalocean.com/community/tutorials/how-to-install-rails-and-nginx-with-passenger-on-ubuntu

Setup nginx as service
https://www.linode.com/docs/websites/nginx/websites-with-nginx-on-ubuntu-12-04-lts-precise-pangolin

run:
gem install rails
bundle install
rails g devise:install


sudo mv nginxrc.sh /etc/init.d/nginx
sudo chmod +x /etc/init.d/nginx
sudo /usr/sbin/update-rc.d -f nginx defaults
