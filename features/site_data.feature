Feature: Site data
  As a hacker who likes to blog
  I want to be able to embed data into my site
  In order to make the site slightly dynamic

  Scenario: Use page variable in a page
    Given I have an "contact.html" page with title "Contact" that contains "{{ page.title }}: email@me.com"
    When I run jekyll
    Then the _site directory should exist
    And I should see "Contact: email@me.com" in "_site/contact.html"

  Scenario: Use site.time variable
    Given I have an "index.html" page that contains "{{ site.time }}"
    When I run jekyll
    Then the _site directory should exist
    And I should see today's time in "_site/index.html"

  Scenario: Use site.posts variable for latest post
    Given I have a _posts directory
    And I have an "index.html" page that contains "{{ site.posts.first.title }}: {{ site.posts.first.url }}"
    And I have the following posts:
      | title       | date      | content         |
      | First Post  | 3/25/2009 | My First Post   |
      | Second Post | 3/26/2009 | My Second Post  |
      | Third Post  | 3/27/2009 | My Third Post   |
    When I run jekyll
    Then the _site directory should exist
    And I should see "Third Post: /2009/03/27/third-post.html" in "_site/index.html"

  Scenario: Use site.posts variable in a loop
    Given I have a _posts directory
    And I have an "index.html" page that contains "{% for post in site.posts %} {{ post.title }} {% endfor %}"
    And I have the following posts:
      | title       | date      | content         |
      | First Post  | 3/25/2009 | My First Post   |
      | Second Post | 3/26/2009 | My Second Post  |
      | Third Post  | 3/27/2009 | My Third Post   |
    When I run jekyll
    Then the _site directory should exist
    And I should see "Third Post  Second Post  First Post" in "_site/index.html"

  Scenario: Use site.categories.code variable
    Given I have a _posts directory
    And I have an "index.html" page that contains "{% for post in site.categories.code %} {{ post.title }} {% endfor %}"
    And I have the following posts:
      | title          | date      | category | content            |
      | Awesome Hack   | 3/26/2009 | code     | puts 'Hello World' |
      | Delicious Beer | 3/26/2009 | food     | 1) Yuengling       |
    When I run jekyll
    Then the _site directory should exist
    And I should see "Awesome Hack" in "_site/index.html"
