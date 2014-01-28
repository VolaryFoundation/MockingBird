MockingBird (Data Manipulation WebSite)
================

The server acts as a webpage for group and other feature's data storage. The system is a client of the Eagle server (https://github.com/VolaryFoundation/Eagle) 
You will need to hook up to a local eagle server to use this system. See read me on above repo link to help with setup.

Systems being used: Sinatra, SASS, MongoDB, HAML, Shotgun

Setup:
------
*Clone the code base from git hub*  
    `git clone git@github.com:VolaryFoundation/MockingBird-API.git`

*Change the Direcotry*
    `cd MockingBird-API`  
    
*Copy and update database yml file*  
    `cp example_env.rb env.rb`
Update the file with database information if you want a non-standard setup
    
*Load the ruby gems:*  
    `bundle install`
    
*create database* !IMPORTANT You most have Eagle running before performing this step  
    `rake db:seed`

*Load the server*  
    `shotgun`
    
*Notes:*  
The server default URL is: http://localhost:9393/  
Access the page through the root.


For Development
---------------
*Load SASS compiler watch function*  
    `sass --watch assets/widgets.scss:public/css/widgets.css`   

*Code Standards:*  
* HAML on html
* Strait javascript (No coffee script (Exception: Testing))  
* indent spacing (2 spaces)


For Testing
---------------
We are using rspec to do unit testing.

to run test: rake spec

