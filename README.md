CLI CRM Application
-------------------

Description
----------

CRM app is a Customer Relations Management tool.
CRM app can store business contact details retrieved from Yelp's Fusion API and log all customer interactions.

Features
-------------------
- Support for multliple user logins
- Find new customers via Yelp's local-search service
- Log and track all interactions with businesses
- Search customer interaction history by business, user or date


MVP
------------------
- Store business data retrieved from Yelp Fusion API in a local database
- Create a new record
- Update record status and description
- Delete record 
- View all business contacts


Stretch Goals Acheieved
------------------
- Filter records by business, user and contact date 


Suggested improvement
------------------
- Fully utilise Yelp Fusion API search options
- Selective record store for Yelp data retrieval to avoid duplicate data
- Improved data entry validation
- Add login password protection
- Refactor existing code
- Improve UI (Menu nativation, styling and window refresh)
- Add a KPI analytics module for managers


Install instructions
-------------------

1. Fork and clone this lab.
2. Move into the cloned directory in terminal and run 'bundle install'.
3. Run 'ruby bin/run.rb' to run the application.
4. Create a user account by entering a username of choice when prompted.


Operation instructions
-------------------

1. Enter username

2a. Login will check if user already exists or create a new account
  
  <img src="readme-img/1-login.jpg" width="400" >

2b. Login will check if user already exists or create a new account

  <img src="readme-img/2-loginmenu.jpg" width="400" >

3a. Select '1' on the options menu to 'Search Businesses by catagory and location'
  
3b. To search enter a catagory and location seperated by a comma.
   The search results are limited to 10 at a time via an application preference.
   The search results are automatically saved to the local application database.

  <img src="readme-img/3b-search-example.jpg" width="800" >
  
4. Select '2' view 'contact history'.

  <img src="readme-img/4-contact-history.jpg" width="400" >


  <img src="readme-img/5-new-record.jpg" width="800" >


  <img src="readme-img/6-status.jpg" width="300" >


  <img src="readme-img/7-description.jpg" width="800" >


  <img src="readme-img/8-saved-rec.jpg" width="1000" >


  <img src="readme-img/9-all-records.jpg" width="1000" >


  <img src="readme-img/10-display-one-business-record.jpg" width="1000" >


  <img src="readme-img/11-login-as-mark.jpg" width="400" >


  <img src="readme-img/12-display-only-my-records-mark.jpg" width="1000" >


  <img src="readme-img/13-display-given-user-record.jpg" width="1000" >


  <img src="readme-img/14-search-rec-by-date.jpg" width="1000" >


  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

