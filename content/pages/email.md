# Less sucky e-mail
What are current options for reading/sending mail? 

* Webmail 
Webmail requires a browser. And *modern* browsers are resource-heavy and complex.
* Thunderbird / Outlook / Any other fat GUI client
Why something so complicated for just reading and sending email?
Last time I checked Thunderbird had thousands of bugs.
* Doing mail UNIX style. The option that sucks less!

## Email done right: The tool stack
This is not a guide, but rather a recomendation on which tools to use. 
These tools will work in synergy and allow you to send, receive and search emails while being in full control of the process (and being able to customize it your own way, if you decide so)

* isync/mbsync - Mail Transfer Agent. Synchronize IMAP folders from your mail provider to your local filesystem.
* msmtp - SMTP client. Sends email. 
* mutt - Mail User Agent. Allows you to browse your email
* notmuch - Mail Indexer. Index email so that you can do quick searches.

Then I just use mutt to browse my email, which is stored locally. 
There is a a cron job (mbsync -a) that synchronizes the remote IMAP folders with my local filesystem.
My mutt is configured to use msmtp for sending mail.
  
# Advantages of this system
* Follows unix philosophy of separation of concerns. You will use small, lightweight and modular components.
* Free and open source
* Backup friendly. Emails will be treated as files on your local filesystem. 
This allows you to backup emails as you would normally backup other files.
* Snappy experience.
* Low resource usage. Even on a low end device, you will be able to read your email, without any hipcups.

# Disadvantages
* Requires work to setup. 
