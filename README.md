TODO:

Make sure all entry times ACROSS JOB TICKETS for the SAME USER do not conflict





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




DONE:

Add feature to pull up all Job Tickets and Entry with end time in set 24 hour range

Start time and End time are filled in and valid time

What I did:
Admin users
    * Can do just one admin user/ preset username
    * Can see all/ edit all
  Regular users
    * Can only mess with their own
    TODO:
        Add this to set_ticket in ticekts_Controller
        
* Figure out best way to send every 24 hours worth of data
  Cron job every 24 hours upload last 24 hours csv to google docs
  http://gimite.net/doc/google-drive-ruby/
  
* Made Create Entry button on ticket view page BIG, green or something / Other buttons as well like update entry in edit

* Download last 24 hour (previous work day, not weekends, midnight + 24 hr) CSV button 

* Make Entry shows as Year-Month-Day HH:MM Military time , no timezone
    DateTime formatting:
    https://hackhands.com/format-datetime-ruby/
    t.strftime("%Y/%m/%d %H:%M:%S")
    
* Add First Last name to User
* Use "First Last" (one cell) name in CSV instead of email

To test this I created user:
admin@admin.com
with password: 
password




Done:
Export CSV
	By day, group by user,

	https://docs.google.com/spreadsheets/d/1jorV27kD6EGwTusgHrZWTj4UHHy4BRH-TBZ2VspAwJw/edit#gid=667278848

Make sure all links work, delete I guess


Server for this is at:

sshrackspace

alias sshrackspace='ssh root@104.130.225.97'

ai -y mysql-server-5.6 libmysqlclient-dev
mysql -uroot -ppassword

DROP DATABASE workorders;

CREATE DATABASE workorders;

su -  bbarrows
cd workorders
git reset --hard HEAD
git pull

export RAILS_ENV=production
RAILS_ENV=production bundle install
#might not be necessary
#rails g devise:install
RAILS_ENV=production rake db:migrate
RAILS_ENV=production bundle exec rake assets:precompile

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
