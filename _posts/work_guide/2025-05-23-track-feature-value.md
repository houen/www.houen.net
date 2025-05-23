---
layout: post
title: "Track feature value"
description: "Track feature value to remove features that do not perform"
tags: [software development, work guide, product development, reducing risk]
date: 2025-05-23 07:52 +0200
---

From the hidden [cost of long-tail maintenance]({% post_url work_guide/2025-05-22-the-long-tail-engineering-cost-of-features %}) we see the cost of maintaining a feature in your product. We know a feature costs money, and the more features you build, the more each feature costs.

Because of this it is important to track the performance of your features. By tracking them we can remove those that do not perform.

To track performance, first we must try to quantify how much true business value a feature is bringing in.
Did you change the way the signup process works - how did that affect drop-off rate during signups?

The best way to get data on which features are performing is with raw analytics data. So a feature introduced a new *call-to-action* (CTA) button on a page. How is that new button converting? Do not simply look at the raw click-through rate. Here are some suggestions:

- What percent of visitors to the page click the new button?
- How many people convert via the new button, and what is their *customer lifetime value*?
- Start a funnel from this new CTA button, and see how it performs. How many people drop off in the funnel? Do they come back? How does this compare with the other funnels? Would it be better to let the customer explore the page longer before showing them a CTA button?

#### Tracking non-trackable features
Sometimes, there is no simple or hard-and-fast way to measure a features performance. But we must still make an effort to try. At least make it a regular topic in the regular product meetings.

Just opening a conversation around "how is feature x, y and z performing? *And how do we know they are performing this way*" will improve your product pipeline. The last part is very important.

It is not enough that someone simply states that something is performing wonderfully. These are likely the same people who pitched the feature in the first place. They put their ass on the line to make this happen. Of course they are going to stand up for their work. We need to understand *how* we know that something is performing.

We prefer data. Sometimes we don't have that. We only have feelings and anecdotes. At the very least we need to know how we arrived at a feeling concerning a feature.

{% include work_guide_revisited.html %}
