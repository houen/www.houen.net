# Thoughts on Rails Testing

## Test the real thing as much as possible
We test to make sure the user gets a good experience and the company keeps making money. Anything else is just extra.

- System tests (integration tests in earlier Rails versions) are what counts.
- Do not test controllers unless it makes sense to do so. And it almost never does.
- Do not unit test everything.
  - Unit tests should be used where they make sense, but are essentially just a help for us programmers.
  - A unit test cannot replace a system test.
- Caveat: Core code should be extensively unit tested. See below.

### Core code should be extensively unit tested
What makes sense to always unit test is something _core_ to the business. Most often this will be something involving money. 
The reason for doing so is to make double-sure these parts do not break. System tests plus unit tests.

When I first started in hobby electronics, we learned an iron-clad rule. _Always turn off the power twice_.
Before tinkering inside something with voltage that can kill you, you turn off the switch. Then you also unplug the device. Double safety.
You have to forget twice.

This made so much sense it stuck with me ever since.

We should do the same for the programming paths that cannot go wrong, ever.
We do this by both system testing and unit testing. 

> If it is dangerous, make double sure. In programming, this means system and unit tests.

For instance that a Clickout requires either a `cpc` or `cpl + clicks_per_lead` should be unit tested. Because if this fails we might lose a lot of money _without realising it_. 
The "without realising it" part is important. 

If a bug somewhere would only affect a few percent of users and would be caught by system tests, it does not need extensive unit testing.

If a bug somewhere would be caught and fixed immediately, system testing is enough.

But if something would be both silent and deadly, it should be _massively_ unit tested.

### Only a system test sufficiently proves that something works
This is perhaps quite controversial, and everything should be taken with a grain of salt. 
The longer I work in programming, the more often the answer is "it depends".

However, we employ this "rule" because no ~~user~~ customer will ever care about your unit tests. 
A user does not give a crap whether all your unit tests are passing or running very fast. 
They care whether your product works. 
And system testing what is important to the customer is the safest way to ensure they are happy with your product. 
And then your bosses will be happy. And hopefully they will make you happier as a result. If not, better find another job. 

> Happy customers == happy bosses == happy programmers

### Focusing on unit tests allows for radical code changes


Once more for emphasis:
> Only a system test sufficiently proves that something works.

### Test is code. Code is debt
Tests are code. Code that must be maintained. Code that must be adapted to react to change. Every line of code we add makes it slower to add future lines due to code complexity.

So **more tests leads to slower development**. 

For this reason we should keep our tests as lean as possible. Anything important should be tested. But only once and as efficiently as possible.
Note that efficiently here does not mean how fast a test runs. 

### Efficient Tests
How efficient a test is is a factor of:

- How well it covers the business case it protects.
- How well it communicates the business case it protects.
- How easy the test is to understand as a developer.
- How easy the test is to understand as a _new developer on the project_.
- Short and simple beats long and clever. 
  - Clever == Complicated == hard to understand == _BAD TEST_.
- How effectively the test helps to pinpoint what went wrong when things go wrong
  - Good: `test "offer title starts with the car make name"`
  - Bad: `test "offers have correct content"`
- How fast it is to adapt the test when the business requirement changes
  - And it _will_ change. The only constant is change.

See "A good test" section below for an example of a test that does the above.

## How to test

### The basics

We use Minitest for testing.
We use `test "xyz does x" do` blocks for describing tests. No describe or context.

The above can take a little getting used to if one comes from an rspec background like I did. However, I think you will find this a very comfortable test flow after a while. 
I used to be a die-hard rspec fan. But by now I have not missed rspec in several years.

### Test focus

A test should have a clear focus: Set up the test state and then assert things that make sense as a group. Things that have high cohesion. In general a test should set up the minimal amount of state required to test what it is for, then test only things that belong together. Prefer smaller tests that clearly communicate what functionality they are there to ensure.

A tiny test that asserts just one thing is best. The only reason to assert more at once is test run performance. This is a tradeoff. But one where we strongly prefer more focused tests.

A lot of legacy tests try to test waaay too much in a single test. We prefer testing only things that belong together.

## Writing Readable Tests

A test will be written once, and then read and adapted many times. Help future you or future me. Take the time to make the tests ready to read and understand.

### Given / When / Then

Avdi Grimm had written and talked about a great concept: [Confident Code](https://www.youtube.com/watch?app=desktop&v=T8J0j2xJFgQ&themeRefresh=1).

Translated to testing, this means following cumber's _Given_ / _When_ / _Then_ format. A test should generally conform to the same basic structure as Gherkins Given, When, Then: (Setup, Do, Assert)

For small tests these can be just separated by black lines. Note that Setup is not the same as the setup code block. It could be, but that is just a part of the setup phase shared by all tests in that test class.

### Example:

See the implicit Given / When / Then blocks in the below test:

Given: Performs a basic test of the precondition that the campaign is returned.
When: Changes the campaign to flip the condition - it no longer belongs to the same provider as the ad
Then: The campaign is no longer being returned.

```ruby
test '.for_ad_detail does not return campaigns for other providers than the provider an ad detail belongs to' do
# Given
ad1 = audi_a3_ad_detail
c1 = FactoryBot.create(:campaign, provider: ad1.provider, car_model: ad1.car_model)
assert_equal c1, Campaign.for_ad_detail(ad1)

# When
c1.update!(provider: FactoryBot.create(:provider))

# Then
assert_not_equal c1, Campaign.for_ad_detail(ad1)
end
```


### Happy Path and Sad Path
In testing, we talk about "the happy path" - the case where everything works. The user inputs correct data; a Clickout works as expected and we make money; a provider import of offers works when given good data.

We call this the happy path. Always start by testing the happy path - what we want to happen. After that, test the case where things go wrong - the Sad Path

**Being negative is good - in moderation**

The users and data providers can sometimes provide incomplete or outright wrong data. 
It is good to build tests that ensure the app works correctly with such input. However, be careful not to overdo negative testing.

When testing the Sad Path, be sure to think about what is likely to go wrong. What do we expect to go wrong? 
A canonical example would be a user forgetting to input a dot in their email. 
For this reason we test that the system rejects wrong emails. 
However, testing for every type of wrong email we can dream of, would be going too far. 
Test the happy path, and test that we guard against the Sad Path.

Be just negative enough to ensure a good user experience. This is our key goal.

As an example, consider an importer of provider data. For these, we should, among others, test that:

- Happy Path The importer works as expected when given correct data
- The importer can gracefully handle a row of bad csv data
  - The import should then ignore this row and continue
  - At best, this should also be reported softly to business or devs. Silent failures should be avoided
- An import which would cause a provider to lose over 50% of their current number of offers causes the entire import to fail.
- A failed import should be reported **LOUDLY**.
- When the import fails, the providers current offers should not be deleted



With the above tests, we ensure that:
- The key flow works as expected (Happy Path)
- We can recover from a bit of bad data
- If we face such bad data that we cannot continue, we stop and LOUDLY report it, since this threatens our core business
- We handle the above failure gracefully by not removing the current provider offers

This is a real-life example. Our importers used to not do this, and suddenly 50% of our offers were gone for a full day due to a bug causing the provider feed to be empty.

## A good test

Talk is cheap. Let us look at some code:

```ruby
# From Search::Results::Auto::PreisBisTest
# The test name has been made slightly clearer here than in the code
# - there is always room for improvement!

test 'content: it applies implicit seo page filters to offer search' do
create_offer(name: "Audi A3 1000", price: 1000)
create_offer(name: "Audi A3 5000", price: 5000)
create_offer(name: "Audi A3 5001", price: 5001)

visit '/auto/bis-5000-eur'

assert_offer_titles ["Audi A3 1000", "Audi A3 5000"]
end
```

In the above example it is extremely easy to see what the test does: It applies a filter on offer results based on the SEO page the user is visiting, in this case /auto/bis-5000-eur. The test is split up into implicit Given / When / Then blocks, similar to Cucumber / Gherkin. This makes it easy to see the parts of the test:


Given: 3 offers exist, with one standing out (price: 5001)
When: I visit the seo page
Then: I should see just the offers with price less than or equal to 5000



Note that much of the test complexity is hidden in helper methods (in minitest this is just a method). def create_offer is defined in and used throughout the test to set up an offer with meaningful defaults. assert_offer_titles is used heavily in the integration tests because the offer titles are a very quick and clear way of verifying what offers are returned.

By combining these and setting a title-relevant field (price) we can quickly set up a test that can very easily adapt to changes. If for instance the bis-5000-eur should instead mean "less than" without the equals, we only have to change the test name and remove a title from the assert_offer_titles.



## A Bad Test
This is to give an example of what not to do. I have helped add 2 lines to this mess myself in 2020/2021.

Here it is, in all its horrible glory. It is so bad I might add it as part of my interview roster as a test to please look at and say what is wrong.



Comments below.

```ruby
should 'display proper text content' do
    DriverHelper.use_javascript_driver
    
    visit '/stadt'
    
    breadcrumbs       = all('.breadcrumbs li').collect(&:text)
    breadcrumbs_links = all('.breadcrumbs li a').collect { |link| link['href'] }
    
    assert_equal 'Startseite', breadcrumbs[0]
    assert_url_match '/', breadcrumbs_links[0]
    assert_equal 'Gebrauchtwagen in Deiner Stadt suchen und vergleichen', breadcrumbs[1]
    
    assert_equal 'Entdecke alle Gebrauchtwagen in deiner Stadt! Schnell vergleichen ✔ Komfortabel ✔ Günstigste Angebote ✔ täglich alle neuen Gebrauchtwagen in deiner Stadt vergleichen ✔', find('meta[name="description"]', visible: false)['content']
    assert_equal 'Alle Gebrauchtwagen in Deutschland auf einen Blick | 12Gebrauchtwage...', page.title
    assert_equal 'noindex,follow', find('meta[name="robots"]', visible: false)['content']
    assert_equal 'Gebrauchtwagen in Deiner Stadt suchen und vergleichen', find('h1').text
    assert_equal 'Gebrauchte Autos in Großstädten', find('h2').text
    assert_equal 'Wähle eine Stadt und gelange direkt zu den aktuellen Gebrauchtwagen-Angeboten in der Nähe.', find('h3').text
    assert_equal 'Gebrauchte Autos auch in Deiner Stadt:', find('.zip-code-search .heading-small').text
    
    # have 2 small search form with zip code
    # - search widget with zip code
    within('.small-search-with-zip') do
      fill_in('s[zip]', with: '88662')
      wait_for_ajax
      assert_equal '0 Treffer', find('button[type="submit"]').text
      find('button[type="submit"]').click
      assert_equal 'Gebrauchtwagen in Übersee | 12Gebrauchtwagen.de', page.title
    end
    
    
    visit '/stadt'
    # - search widget only zip code
    within('.zip-code-search') do
      fill_in('s[zip]', with: '88662')
      assert_equal 'Treffer anzeigen', find('button[type="submit"]').text
      find('button[type="submit"]').click
      assert_equal 'Gebrauchtwagen in Übersee | 12Gebrauchtwagen.de', page.title
    end
end
```

This test has so many issues it is not even funny.
- The test does way too much
- The test will not clearly communicate what went wrong (display proper text content failed)
- The test In no way at all has a clear intent: It tests:
  - Breadcrumbs
  - SEO meta description
  - SEO page title
  - SEO robots
  - h1
  - h2
  - h3
  - Cities box header
  - Cities box CTA button text and AJAX
  - Cities box links to cities page
  - Cities page:
    - Header 
    - Custom zip code input box CTA button label 
    - Custom zip code input box CTA link

**The test sets up _six_ different states:**
- `visit '/stadt'`
- `fill_in('s[zip]', with: '88662')`
- `find('button[type="submit"]').click`
- `visit '/stadt'`
- `fill_in('s[zip]', with: '88662')`
- `find('button[type="submit"]').click`

**The test does everything manually all the way down at the metal layer**
Notice how it says:

```ruby
within('.small-search-with-zip') do
fill_in('s[zip]', with: '88662')
```

Contrast that with these helpers: 

- `set_search_filter(:make, 'Audi')`
- `set_search_filter(:zip_code, '13086').`

Which ones are easier to use and understand?

The latter ones here take advantage of a single helper method to set search filters. It encapsulates all logic related to setting a search filter using the sidebar. Which one more clearly communicates what is happening?

> Fun extra: The css class .small-search-with-zip is misleading. \
> It is not a small search. It is small in comparison to others. But it is the largest search bar on the page tested. \
> Not only does the test not help us understand, it also misleads us. In order to understand the test we must first understand the code. \
> It should be the other way around. Tests should help us understand the code.

Tests are our source of truth. And Truth should be simple and easy to understand.

A well written test is also good documentation.

Note that since setting the zip code on the /stadt page is not a very common thing to do. It should _probably_ not be extracted to a common helper, but the case stands that it should be made much more readable.

This could be as easy as changing the test name. Something like test "inputting a zip code in top search bar updates search button label with offers count". Although a bit long, this test name clearly communicates what is happening. I also changed the name to "top search bar" despite the bad css class .small-search-with-zip. This is because there are two small searches with zip on the page. One at the top and one at the bottom. And the one on the bottom is the smallest, but the top one is the one called .small-search-with-zip.

The above highlights another issue with the original bad test: It relied on css selectors in a way that did not help with understanding at all. In fact, the class name made it harder to understand what was going on. But giving the test a good name screams at us that the css class name is bad. The test is again a clear source of truth. And it tells us that our code is lying.

The fix here is, of course, to rename the css class into something that makes sense, like .top-search-bar. However, we are about to move GW to monolith, at which point we can fix the css class names as we build them. So it does not really make sense to do this refactor now.



## "Test one thing" can also mean one product concern
Sometimes it can be okay to test more than one thing which at first glance do not seem fully cohesive from a code standpoint, but which serve the same product case. Take this example:

```
assert_basic_seo_content(
path:                    '/auto/audi/a3?extra_param=should_be_ignored_and_removed_from_canonical',
code:                    200,
index:                   true,
follow:                  true,
canonical:               '/auto/audi/a3',
title:                   'Audi A3 gebraucht kaufen | 12Gebrauchtwagen.de',
desc:                    'Du möchtest dir einen gebrauchten Audi A3 kaufen? Vergleiche über 6 Audi A3 Gebrauchtwagen Angebote im Netz und finde so dein neues Auto! Schnell vergleichen ✔ Komfortabel ✔ Günstigste Angebote ✔ täglich alle neuen Audi A3 Gebrauchtwagen vergleichen ✔',
h1:                      'Audi A3 Gebrauchtwagen suchen und vergleichen',
h2:                      ["Gebrauchte Audi A3 in Deiner Stadt"],
h3:                      ["Audi A3 10178 6", "Audi A3 10178 5", "Audi A3 10178 4", "Audi A3 10178 3", "Audi A3 10178 2", "Wähle eine Stadt und gelange direkt zu den Gebrauchtwagen-Angeboten in der Nähe."],
link_rel_next:           '/auto/audi/a3?page=2',
link_rel_prev_from_next: '/auto/audi/a3'
)
```

At first it looks like it is horrible. It is doing much of the same as The Bad Test above.

However, there is a subtle difference: It is wrapped in a helper which is cohesive. It ensures that basic SEO rules are followed. That is the cohesion of this test helper. It verifies that the most basic SEO rules for search result pages are not being broken:

- HTTP status code is correct
- Canonical path ignores irrelevant parameters
- Has expected robots index
- Has expected robots follow
- Has expected canonical
- Has expected page seo title
- Has expected page seo description
- Has a single h1 tag with expected content
- Has expected h2 tags
- Has expected h3 tags
- Has a link[rel=next] tag to expected page
- Has a link[rel=previous] tag back to self from the link[rel=next] page

These are important rules to follow and serve as valuable regression tests. All covering basic SEO product case. Not having such a test for product pages has bitten us in the ass before, which is why I created a helper to quickly and easily cover the SEO basics.

> Test cohesion can also means that the product case under test is cohesive

## Test writing inspiration
Andrew Kane (creator of Searchkick) writes short, clean, readable tests by working extensively with small test helper methods. [Example](https://github.com/ankane/searchkick/blob/master/test/boost_test.rb)