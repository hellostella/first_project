# Personal Finance Manager

Welcome to your Personal Finance Manager!

Are you a compulsive spender?
or
Do you just want a better means of monitoring your accounts?

Well you have come to the right place!





For Users: 
-
- You will be able too:
- Enter Transactions and record Payees & Categories 
- View all Past and Present Transactions as well as Edit/Delete your Transaction History
- Check your Balance! 
- View Transactions by Category (Filter Options) 

Instructions to Run:
-  Please CREATE DATABASE (createdb) called "finance"   
-  Iniate a new repo and please fork this repo, following a git pull please ensure the folder structure is intact (Folders: db, lib, spec, project_setup)
-    Please make sure gems are installed, and rspec is installed (bundle install/ rspec --init in command line)
-    Please load schema (create tables) from the db folder (Command Line: psql -d finance < finance_schema.sql )
-    Please inject seed into the loaded schema ( Ensure you are in parent directory & Command line: bundle exec ruby finance_seedrb) 
-    Finally run the app.rb file in the command line (Command Line: bundle exec ruby app.rb) 
-    Enjoy tracking your spending!
              
