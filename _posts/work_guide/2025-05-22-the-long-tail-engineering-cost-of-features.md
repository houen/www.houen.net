---
layout: post
title: "The long tail engineering cost of features"
description: "Software features cost more than initial development time. Every time you decide to add a feature you are choosing to not add a different future feature."
tags: [software development, work guide, reducing risk, product development]
date: 2025-05-22 09:42 +0200
---

If something takes 40 hours for engineering to build, one might think "ah, we only have to invest a single man-week". Yes, but this is just the up-front cost. After this comes:

- Maintenance
- Bug fixes
- Added code complexity
- Potential added data model complexity
- Customer support
- New developers learning about the feature during onboarding

These are all small at first, but they add up over time. The real killer is the code complexity.

> For every feature you add you are increasing the cost of *new features as well as maintaining the ones you already have*.

This relationship is not linear. It gets more and more expensive with each feature added.

[//]: # (So why is it like this? A couple of reasons:)

[//]: # ()
[//]: # (##### Engineers must fit all business cases and code in their head)

[//]: # (When an engineer needs to change something about a codebase, they first need to wrap their head around all the business cases and code points they will be touching.)

As an example: Say we are changing a user signup flow.

We want to add a "reminder" email to be sent in case they have not completed their profile 7 days after creating their account.

I will illustrate this by writing very simple Gherkin code (standardised way of representing tests) for the features.
Expect application code to normally grow at least as much in complexity as the tests.

#### First feature
Okay. We need to add a scheduled job with code to check whether a users profile is completed.
This job should be scheduled for 7 days after account creation.
If the profile is not complete, it should send an email following a template. Here's the Gherkin code for it:

> Feature: Reminder email\
> Given I have created a user account\
> When 7 days have passed\
> And I have not completed my user profile\
> Then I should receive a reminder email to complete my profile\

Fair enough. We code it, write tests for it, deploy it, get it signed off on. Done.

#### Second feature
Now comes the next feature: There should be an "admin" type user, which can manage a subset of users under their company umbrella.

For this we need to add a user role field, and the back office admin section for this new user type.

However, now comes the requirement: _admin users should not receive a reminder email_.
So on top of the features we need to add, we need to change the existing reminder email feature:

> Feature: **Regular** users receive reminder email\
> Given I have created a user account\
> When 7 days have passed\
> And I have not completed my user profile\
> **And I am not an admin user**\
> Then I should receive a reminder email to complete my profile\
> \
> **Feature: Admin users should not receive reminder email**\
> Given I have created a user account\
> When 7 days have passed\
> And I have not completed my user profile\
> And I am an admin user\
> Then I should not receive a reminder email to complete my profile\

It is a small change, but it still needs doing. Someone needs to think of it. Someone needs to do it. And notice that _we doubled the number of tests engineers have to maintain_.

Here are some associated costs to the company:

- Change cost: The change must be discussed. It must be planned. Code must be changed. Tests must be updated. Code must be reviewed. Features must be re-reviewed by the product owner.
- Risk: While implementing the admin user, the engineers might introduce a new bug in the reminder email system.
- Risk: Any future emails now possibly need to distinguish between user roles.

#### Third feature
Then we add a new user type, accounting, which also should not get the "regular user" emails, but should get the
"activity for users you manage" email.
Now we need to expand the if-statements in both the "reminder" and "users you manage" emails.

Here comes the new Gherkin:

> Feature: Regular users receive reminder email\
> Given I have created a user account\
> When 7 days have passed\
> And I have not completed my user profile\
> And I am not an admin user\
> **And I am not an accountant user**\
> Then I should receive a reminder email to complete my profile\
> \
> Feature: Admin users should not receive reminder email\
> Given I have created a user account\
> When 7 days have passed\
> And I have not completed my user profile\
> And I am an admin user\
> Then I should not receive a reminder email to complete my profile\
> \
> **Feature: Accountant users should not receive reminder email**\
> Given I have created a user account\
> When 7 days have passed\
> And I have not completed my user profile\
> And I am an accountant user\
> Then I should not receive a reminder email to complete my profile\

- The first feature was just the cost of implementing that single one.
- The second feature had two necessary changes in order to implement one feature.
- The third feature also had two necessary changes for one feature.

#### Fourth feature
Now say we introduce a new email "activity for users you manage" which is for both admins and accountants.

Now this becomes our new Gherkin. To keep it short, I just include the feature names.

> Feature: Regular users receive reminder email\
> Feature: Admin users should not receive reminder email\
> Feature: Accountant users should not receive reminder email\
> **Feature: Regular users should not receive "activity for users you manage" email**\
> **Feature: Admin users should receive "activity for users you manage" email**\
> **Feature: Accountant users should receive "activity for users you manage" email**\

What happened? We had just gotten used to one feature requiring two changes. Now, one feature required three changes!

> The relationship between number of feature and effort required is not linear.
> It is a slowly growing exponential curve.

The work required for each feature quickly grows in complexity the more features we add.
The interactions between them get more and more complicated. Changes become increasingly costly.
At some point, a feature will have so many interactions that adding one costs 2x, 3x, or 5x the time (salary) of implementing it,
had there been less features in the system.

Here is the full final Gherkin of the four features:

> Feature: Reminder email\
> Given I have created a user account\
> When 7 days have passed\
> And I have not completed my user profile\
> And I am not an admin user\
> And I am not an accounting user\
> Then I should receive a reminder email to complete my profile\
> \
> Feature: Admin users should not receive reminder email\
> Given I have created a user account\
> When 7 days have passed\
> And I have not completed my user profile\
> And I am an admin user\
> Then I should not receive a reminder email to complete my profile\
> \
> Feature: Accountant users should not receive reminder email\
> Given I have created a user account\
> When 7 days have passed\
> And I have not completed my user profile\
> And I am an accountant user\
> Then I should not receive a reminder email to complete my profile\
> \
> Feature: Admin users should receive "activity for users you manage" email\
> Given I have created a user account\
> And I am an admin user\
> And I am managing a user\
> When 7 days have passed\
> Then I should receive an email with the status of my assigned users\
> \
> Feature: Accountant users should receive "activity for users you manage" email\
> Given I have created a user account\
> And I am an accountant user\
> And I am managing accounting for a user\
> When 7 days have passed\
> Then I should receive an email with the status of my assigned users\
> \
> Feature: Regular users should not receive "activity for users you manage" email\
> Given I have created a user account\
> When 7 days have passed\
> Then I should not receive an email with the status of my assigned users\

We see that even with these little tiny features, we **massively** grew the complexity of our tests.
And you can expect the application code to grow similarly.

And these were just teeny, tiny, very simple and easy-to-understand features.
Most of the time features are much more complex, with many more interactions.

This brings up the main point:

> **Every time you decide to add a feature you are choosing to not add a different future feature**.

Knowing this would you like to introduce _just one little feature_ to the application without verifying its value?

#### Note: More engineers is **not** a solution
Of course, you can throw more engineers at it, but this will also increase the overhead of collaboration and management.
With enough people, you will at some point need to split into multiple services.
This again adds an amazing amount of overhead. Hiring more engineers is a patch-job, not a perfect solution.
For more on this, see the book [The mythical man-month](/books).

> **Revisiting my work guide.**
> I have been working on a work guide for a while now. That is an understatement. I started it in 2011. Then I left it to sit for many years. I will try to revisit it again now in little bite-sized posts.
> Click the "work guide" link below for more.