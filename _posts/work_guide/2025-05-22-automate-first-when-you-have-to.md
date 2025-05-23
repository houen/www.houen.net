---
layout: post
title: "Automate first when you have to"
description: "Software Development Work guide: Building unnecessary things leads to company death"
tags: [software development, work guide, reducing risk, product development]
date: 2025-05-22 09:42 +0200
---

> For tech companies, building things without knowing if it is really what your customers need is in my opinion one of the largest contributors to slowing down of development and eventual company death.

Teams can be heavily slowed down by building the wrong thing. If it takes 5 hours per month to do manually, and 30 hours to automate, *do not automate it*. Wait. Six months from now you will have a much better idea of:

- What is really the customer need?
- What is the simplest way to fulfil that need with code?
- How much value will this really bring?

The longer you wait to build something, the better you understand *what to build* and *how to build it*.

## The cost of features
The cost of developing a feature is not as simple as just building it. Of course the cost varies from feature to feature.
But we can get a basic feel for the cost by looking at the people involved.

For each feature, the company will be paying:

- The product owner for designing the feature
- The product team for discussing the feature
- The development team for discussing the feature
- The assigned engineers for building the feature
- QA or the assigned engineers for testing the feature
- The product owner for evaluating and signing off on the development work.
- The product team for discussing how the finished feature works and performs
- The customer support team for supporting the feature
- The development team for fixing bugs related to the feature
- The development team for incorporating the feature code into all following development work.

There are a *lot* of people involved in building each feature! And this is how it looks like in most medium-to-large software companies following modern Agile principles. This is the lean version!

And the above is only considering the up-front cost of building the feature. After that comes [the long tail engineering cost]({% post_url work_guide/2025-05-22-the-long-tail-engineering-cost-of-features %}).

{% include work_guide_revisited.html %}