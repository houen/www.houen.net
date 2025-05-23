---
layout: post
title: Ubiquitous language
description: Ensure developers use the same names and words to describe the business concepts as your business people.
tags: [software development, work guide, culture]
date: 2025-05-23 07:52 +0200
---

In the words of [Martin Fowler](https://martinfowler.com/bliki/UbiquitousLanguage.html): "the practice of building up a common, rigorous language between developers and users".

To put it more plainly:

> A company must always ensure developers use the same names and words to describe the business concepts as your business people.

## Why is it so important?
One of my key takeaways from the amazing [DDD book](https://amzn.to/2KuwMKU) is that a Ubiquitous Language is one of the most important things to create and maintain in a software company. The reason for this is that without a Ubiquitous Language, developers and business people need to constantly mentally translate terms when communicating with each other. It makes it harder for each side to understand each other. It fosters silos between business and dev.

I have worked in companies where there was no Ubiquitous Language. Terms for important domain concepts had drifted twice between business and dev. "Campaign" in code meant either "Project" or "Advertisement" when talking to business. It confused everybody: Leadership, Sales, Product, and Development. It was the largest source of confusion for new developers. And because it had not been handled from the start, it was now a monumental effort to fix in code.

## How do you achieve it?
By making it an explicit requirement. And then doing the work to ensure it happens and stays that way:

- Have a regular work task to make sure Development and Product are still in sync with Business on terms.
- Business is the one deciding what to name terms. They should be agreed on after proper thought and discussion, and then development should follow this
- If a term changes in Business or is wrong in Development for whatever reason, change it.
- Business should not change the terms often. It should be understood that changing terms costs real time and effort for Development. If a term needs to change, it should. But proper care should be taken in choosing terms well.
- Changing terms used in code should be a separate ticket in its own right. It is important work, not an afterthought.

{% include work_guide_revisited.html %}
