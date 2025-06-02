---
layout: post
title: Agile - Use regular retrospectives
description: Retrospectives is the time we take to not just work but *improve how we work*. If your team was a saw, retrospectives is the time you take to sharpen that saw.
tags: [software development, work guide, culture]
date: 2025-06-02 22:09 +0200
---

### Agile - Use regular retrospectives
Retrospectives are in my opinion the most important part of Agile.

Retrospectives is the time we take to not just work but *improve how we work*. If your team was a saw, retrospectives is the time you take to sharpen that saw.

Retrospectives should be held once every sprint or every two weeks. This fits with most sprint schedules, either every halfway or at sprint end.

Even if your team uses none of the other parts of Agile, adopt regular retrospectives.

#### Main purposes
- Improve team collaboration
- Remove team roadblocks
- Having a space to bring up issues which need to be brought higher up the chain
- Letting team members vent their issues
- Celebrate successes
- Practive gratitude
    - A proven way to increase happines, which is a proven way to increase productivity

#### Attendees
- The entire team, both developers, product owners and direct manager if there is one
- A retrospective coach

Note: For this section I will assume a team size of maximum six people. If more people, you will need to adjust as needed.

#### Tools
- A big board or wall
- Lots of post-its
- Semi-fat permanent markers

#### Rules
It is okay to disagree, but we must always be courteous and nice to each other.

#### Process
The team members will be giving answers to three questions:

##### What went well?

1. Everyone writes down at least 3-5 answers
1. Each team member presents their answers

The coach points to the first question "What went well" and asks the team to write down at least three answers. The team should have at least five minutes for this.

After the time is up, every team member presents their answers by putting their post-its on the board one-by-one while explaining them. Nobody else comments, unless it is to clarify the meaning.

By starting with "what went well?" We give the team a chance to both think positively and celebrate each other and what worked. This sets a positive frame for the rest of the meeting.

##### What did not go so well?

Here we discuss *why* something happened without getting into what can be done about it.

1. Everyone writes down at least 3-5 answers
1. Each team member presents their answers
1. Answers are grouped

Questions are answered and explained same as with "What went well?".

Once every team member has done this, answers are grouped so common themes emerge where possible: "Deployment issues" and "The servers crashed again" might be grouped together since both are about servers / devops. "User onboarding is a pain to change" and "Automatic email sending is a mess" might also be grouped since both have to do with technical debt.

How to group answers is very dependent on the business domain and specific team issues. The team will make their own sense of this. They are living with this every day.

##### What can be improved?

1. Everyone writes down at least 3-5 answers
1. Each team member presents their answers
1. Answers are grouped
1. Each team member rates the groupings

In the last question "what can be improved?" we start to try to figure out how we can both fix what was painful as well as improve on what already works.

After answers have been written, presented and grouped like above, the team all come up and show what they find important by placing 3-5 dots on one or more groupings. This way the team votes on what should be done first according to them.

Once answers are voted on, they are discussed as time and energy allows, starting with the ones voted most important.

##### Examples

Here are a couple of examples which are close to what I have experienced in real life retrospectives. The team once again failed to deliver the Sprint, and everyone seem a bit frustrated.

**What went well**

- Coach: "What went well this Sprint. John do you want to start?"
- John: "I was working with the new domain model structure Jane set up for the billing flow. It was a pleasure to code on."
  - [2 more things from John]

- Jane: "I thought the tickets coming from Fred were very high-quality this sprint. Thanks Fred"
  - [3 more things from Jane]
- Fred: "I tried out the Who/Why/What framework for writing tickets as well as Gherkin. It worked better than I had thought. I might start doing it for all tickets"
  - [4 more things from Fred]

**What did not go so well?**

- Coach: "Ok, so what did not go so well? Jane, I see you have a lot on your mind this time?"
- Fred: "We delivered late again this sprint. I know it probably has to do with the legacy code from how much you mentioned it the last couple of times"
  - [4 more things from Fred]
- Jane: "I had to touch the legacy code parts from the previous system. It took forever and was full of bugs. I hate that thing"
  - [5 more things from Jane]
- John: "Yeah about the legacy code. I had to fix a bug with it as well. It took 2 whole days"
  - [2 more things from John]

**What can be improved?**

- Coach: "Okay, it seems like the grouping with the most points by far is the legacy code. Who wants to start?"

- Fred: "I mentioned the legacy code. We keep getting slowed down by. it, and I think we have the time right now to do something about it."

- John: "Yeah, I had legacy code on mine as well. Jane, I think you did too, right?"

- Jane: "Yes. I think most of the pain we are having with it is due to modules A and B. We barely touch anything else in the legacy.

  The main issue for me is that the tests on those are so bad. Maybe we can write a couple of integration tests for just those modules and then try to extract them into smaller units?"

- John: "Yeah, that could work. We could start with A1, A2 and B1"

- Fred: "Ok. Then to get rid of this how about we change the time allocation from the normal 60%/40% to 20% product, 80% tech tasks this upcoming sprint?"

  [John and Jane of course agree to get more time to clean up the painful code, whereafter they move on to discuss the next-most important things to improve, etc. etc.]

{% include work_guide_revisited.html %}