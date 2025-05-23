---
layout: post
title: Kill unneeded features
description: Every time you keep a feature you are choosing to not add a future feature. Remove features which do not perform.
tags: [software development, work guide, product development]
date: 2025-05-23 08:13 +0200
---

When a feature is not performing, you should remove it as soon as possible. You pay a small price to remove it, and in return you get:

- Future features are cheaper and easier to build.
- Current features are cheaper and easier to maintain.
- You can faster react to changing business requirements.
- Less time spent on technical cleanup / refactoring tasks.
- Happier engineers. Engineers *love* removing code, because it means their future job gets easier.


## Example: Building something nobody needs

Here is an example of all of the above from real life:

I once worked in a company where we were tasked with building a highly sophisticated way of automatically generating content on behalf of the customers. There were five or seven different set of rules to follow, and the customers could choose between these. This choice would then seed an algorithm to build randomised personalised content. The content would then auto-grow every month. Everything needed to be customisable by the customer. Content would depend on the generated content of previous months.

This came straight from the top and was the most important feature ever. At the time I did not know enough to push back properly.

It took 3 people two months to build everything related to this. A total of 6 man-months of work. It also *severely* complicated the data model.

Several years later I briefly worked with the same company again. One of my first tasks was *removing the feature*. At that point it had been slowing down development for years.  It was responsible for much of both the code complexity and database size.

With the time spent removing the feature again, plus the maintenance done in the intermittent years, this single feature cost the company *12-18 months* of developer work. And this is not counting the cost the more complicated data model will have had on slowing down / having to reject other new features.

In the end, the feature was used by under 50 customers. It was something needed by nobody. What the customers turned out to really want was much simpler manually curated content which they could choose from.

Something which could have been done in 1-2 weeks.

The company from the example above did one thing right: When the feature did not work, they removed it again. They waited way too long to do so, but at least they removed it, instead of throwing more good money after a bad feature.

## Conclusion

> Every time you decide to add a feature you are choosing to not add a future feature. Choose your features with care. Track feature value. Keep only those which add real and significant business value. Remove those features which do not perform.

{% include work_guide_revisited.html %}
