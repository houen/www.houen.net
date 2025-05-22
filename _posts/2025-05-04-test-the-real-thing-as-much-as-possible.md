---
layout: post
title: Test the real thing as much as possible
description: "When to use unit tests, the importance of testing core code, and how focusing on high-level system tests enables radical code changes without breaking functionality."
tags: [software development, work guide, testing]
date: 2025-05-04 12:50 +0200
---

> This is part 1 of a series on testing.

## Test the real thing as much as possible
We test to make sure the user gets a good experience and the company keeps making money. Anything else is just extra.

- System tests (integration tests in earlier Rails versions) are what counts.
- Do not test controllers unless it makes sense to do so. It almost only does for APIs.
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
Code where small errors are devastating and not easily spotted. Financial calculations are a good example. How much to charge customers for example.
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

Once more for emphasis:
> Only a system test sufficiently proves that something works.


### Focusing on system tests allows for radical code changes
If a systems tests are too low-level, they must be changed with every little code change. But if a test is essentially:

```
As a new visitor
When I visit /products/books
And I click the product link "Easy testing for all"
Then I should see 1 item in my shopping cart badge
And I should see a total cart price of 15 EUR
```

The above "test" is high-level. I can changes any of the underlying parts without the test breaking. The test does not care How I calculate that cart price total, only that it is correct.

This means I can change whatever I want about the underlying code without the test breaking, as long as the parts a user cares about works.