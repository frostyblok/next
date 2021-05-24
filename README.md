# README

### Table of Contents

1. [Introduction](#introduction)
2. [Setup](#setup)
3. [Running the Application](#running-the-application)

----

# Introduction
This app is written in Ruby on Rails. It's simply a blog application oauth and 2FA authentication.

### Problem Statement
Workflow for how to improve blogging.

----


# Setup
Here's how to test the application on your local computer for development:


### Installation
Follow these instructions to setup your local development environment:

1. Clone the project and `cd` into the project directory

2. Run `bundle install` to all the project dependencies.

3. Edit the `config/application-example.yml` with your correct database credentials
3. Create Facebook login app (https://developers.facebook.com/) and get both the `app_id` and `app_secret`.
4. Create a Google project from https://console.cloud.google.com and get both the `client_id` and the `client_secret`.
3. Run `rails credentials:edit` to add the database secret, facebook id secret, and google secret. Hint: Check the config/secret-example.yml to understand the structure.

4. Run `rails db:setup` to create the database, migration, and run the seed.

----

# Running the Application

1. Run `rails server` to start the rails server.

2. Visit `localhost:3000` to checkout the application.
