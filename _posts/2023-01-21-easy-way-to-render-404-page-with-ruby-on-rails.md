---
layout: post
title: "Ruby on Rails: Easy way to render a very flexible 404 page"
description: "A very quick, easy and flexible way to add 404 errors to a Rails application"
tags: [ruby, ruby on rails, quick tips]
img_path: /assets/2023-01-21-easiest-way-to-render-404-page-with-ruby-on-rails/render-404-easily-with-rails.png
img_width: 200
img_height: 87
---

![The 404 partial we will be using](/assets/2023-01-21-easiest-way-to-render-404-page-with-ruby-on-rails/render-404-easily-with-rails.png)

We often find ourselves needing to render a 404 page from Rails whenever something cannot be found. 
There are many different ways to do this, but so far this is the one I have found to give me the easiest time of it:

## Use a render 404 action in ApplicationController

I normally add some version of this to `ApplicationController` in order to render the 404 error from there. 
This way I can use a completely normal Rails template file. In this case a slim template.

```ruby
class ApplicationController < ActionController::Base

  # ...
  
  def error_not_found
    render '/application/errors/404', status: :not_found
  end
  
  # ...

end
```

Note: This assumes your 404.html.erb template is in `app/views/application/errors/404.html.erb`

## Add a catch-all route to Rails routes

Now we add the following to the very end of our `routes.rb` file:

```ruby
match '*unmatched', to: 'application#error_not_found', via: :all
```

With just these 4 lines, we will catch all unmatched requests in any format and be able to render them just like any other page. This enables us to do things like:

- Our 404 page can use the same layout as the rest of the application, instead of being "special".
- Track the referrer of 404 errors, to find out if they are coming from bad internal or external links.
- Add page suggestions so we have a chance of redirecting users to where they might want to go.
  - Add specific page suggestions based on where the user came from / what it looks like they are trying to go to

However, when we combine this with `rescue_from ActiveRecord::RecordNotFound, with: :error_not_found` we get a powerful way of redirecting users to our 404 page:

## Redirect ActiveRecord::RecordNotFound errors to 404 page

If we rescue from `ActiveRecord::RecordNotFound`, we can add a way to very easily add "could not find that" redirections to our controllers:

So we use `find_by!` instead of `find_by` when appropriate, and expand our `ApplicationController` with a `rescue_from`:

```ruby
class ApplicationController < ActionController::Base

  rescue_from ActiveRecord::RecordNotFound, with: :error_not_found
  
  # ...
  
  def error_not_found
    render '/application/errors/404', status: :not_found
  end
  
  # ...

end
```

## Caveat: Careful with performance

While this makes things very easy for us, the above is also harder on performance than just a plain `/public/404.html` file. 
I have rarely found this to be much of an issues, but be sure to keep your `error_not_found` action lean and fast, and add caching where / if necessary. 
