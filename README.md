# 🎧 Spoti-fejk

A clone of the famous app Spotify for my school project. The app has basic functionalities:
- Login with Google, Facebook, GitHub and local login using **DEVISE**,
- creating songs as artist and adding them to albums,
- creating playlists and adding songs to it,
- searching songs, albums and artists,
- file upload to AWS S3,
- Admin panel using **ActiveAdmin**

<img width="1365" alt="Screenshot 2023-10-08 at 12 29 41" src="https://github.com/BlazOsredkar/Spoti-fejk/assets/91890538/312eac59-c4d9-4672-9606-e9f0d5063c12">

<br>
App home: https://www.spoti-fejk.vrtogo.si/
   

## Getting Started
### 🖥️ Setup

Install gems
```
bundle install
```

### 🔐 ENV Variables
Create `.env` file
```
touch .env
```
Inside `.env`, set these variables.
```
GOOGLE_CLIENT_ID:
GOOGLE_CLIENT_SECRET:

AWS_ACCESS_KEY:
AWS_ACCESS_KEY_ID:

FACEBOOK_CLIENT_ID:
FACEBOOK_CLIENT_SECRET:

GITHUB_CLIENT_ID:
GITHUB_CLIENT_SECRET:
```

### 📊 DB Setup
```
rails db:create
rails db:migrate
rails db:seed
```

### 🎈 Run a server
```
rails s
```

## ⛏️ Built With
- [Rails 7](https://guides.rubyonrails.org/) - Backend / Front-end
- [Render](https://render.com/) - Deployment
- [PostgreSQL](https://www.postgresql.org/) - Database
- [Bootstrap](https://getbootstrap.com/) — Styling

