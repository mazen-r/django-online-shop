# Django Online Shop

## Tech:
- Python
- Django
- PostgreSQL
- Stripe
- Celery
- Redis
- Docker

## Overview
Online shop that's built using the following apps:
### shop
- Contains category and product models, products relates to categories using OneToMany relation
- Supports list and detail views on products
- Recommends products for users
    - Redis is used to store products that are purchesed together
    - Each product assigned with a products set has a score
    - High score products are recommended if the products in cart is present in the set
> **Since only admins can add new products to the shop, Django's built in admin portal is used to add new products**  
### cart
- Simple cart is used to manage users' products to proceed to payment
- Cart's data is saved in the session
> **Saving cart in session isn't a good way if multiple servers are used with a load balancer, storing it in a cache like redis would be better**
### order
- Contains order model, which stores users' info to proceed for payments
- Launches Celery async task that sends an email confirming order
### payment
- Stripe is used as a gateway for payments
### coupon
- Coupons can be added using Django's admin portal
- Each coupon has a code, discount percentage and end date

## How to run the app
- Clone the repo
- Cerate a .env file with the same settings in the env.example file
- Spin up the server using docker:  
`docker-compose up --build`
- ssh into the server container and run db migrations  
`docker-compose exec backend ssh`  
`python manage.py makemigrations`  
`python manage.py migrate`
- Run celery worker  
`docker-compose exec backend ssh`  
`celery -A config worker -l info --pool=solo`
- You can use Flower to monitor celery  
`docker-compose exec backend ssh`  
`celery -A config flower`