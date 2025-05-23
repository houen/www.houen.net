---
layout: page
title: Software Engineering Work Guide
category: work-guide
permalink: /work-guide/
---

This is a collection of thoughts and ideas I have had or come across while working in software engineering and startups.
I try to use these as principles to help me do better work.

## Culture
- [Celebrate process and honesty, not just results]({% post_url work_guide/2025-05-23-celebrate-process-and-honesty %})
- [Ubiquitous language]({% post_url work_guide/2025-05-23-ubiquitous-language %})
- [Silos will hurt your startup]({% post_url work_guide/2016-05-15-silos-will-hurt-your-startup %})
- [Your startup needs a polaroid wall]({% post_url work_guide/2016-05-18-your-startup-needs-a-polaroid-wall %})

## Coding

- [Get to the first production version with as little effort as possible]({% post_url work_guide/2025-05-22-work-guide-revisited-first-version-fast-as-possible %})

## Product development

- [Automate first when you have to]({% post_url work_guide/2025-05-22-automate-first-when-you-have-to %})
- [The long tail engineering cost of features]({% post_url work_guide/2025-05-22-the-long-tail-engineering-cost-of-features %})
- [Track feature value]({% post_url work_guide/2025-05-23-track-feature-value %})
- [Kill unneeded features]({% post_url work_guide/2025-05-23-kill-unneeded-features %})

## Testing

- [Test the real thing as much as possible]({% post_url work_guide/2025-05-04-test-the-real-thing-as-much-as-possible %})

---

Old work guide: These parts have not been ported to posts yet

---

### Pull Requests / Merge Requests
A Pull Request (PR), or Merge Request (MR) is the act of requesting to pull / merge code from one Git branch into another. They are called Pull Requests in GitHub and Merge Requests in Gitlab. They are exactly the same thing, and will have one or the other name in a company depending on the code organisation platform used.

#### Reviewing pull requests
##### Always be polite and friendly
A pull request is a place for friendly collaboration. It is not a battleground. Always be nice and friendly to each other.

##### Misunderstandings can very easily happen
Remember, it is very easy for misunderstandings to happen over a text-based medium. Something you write in a slightly annoyed tone might be read as a fiery insult by the receiver. Just dont do it.

Jokes are okay, but should be used with caution.

##### Solving disagreements
Strong disagreements happen. It is best to solve these face-to-face, else over a video call, or lastly via synchronous chat.

Pull requests are *not* the place to have an argument.

Come to the best agreement you can. Then respectfully describe the different viewpoints and what the outcome of the discussion was. If you cannot come to an agreement, escalate to the lead.

Never be sarcastic or ironic. It is rude and almost guaranteed to be misunderstood.

## Agile
Agile is such an integral part of our work life today that it deserves its own section.

### Regular retrospectives
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

- Fred: "I wrote the legacy code. We keep getting slowed down by. it, and I think we have the time right now to do something about it."

- John: "Yeah, I had legacy code as well. Jane, I think you did too, right?"

- Jane: "Yes. I think most of the pain we are having with it is due to modules A and B. We barely touch anything else in the legacy.

  The main issue for me is that the tests on those are so bad. Maybe we can write a couple of integration tests for just those modules and then try to extract them into smaller units?"

- John: "Yeah, that could work. We could start with A1, A2 and B1"

- Fred: "Ok. Then to get rid of this how about we change the time allocation from the normal 60%/40% to 20% product, 80% tech tasks this upcoming sprint?"

  [John and Jane of course agree to get more time to clean up the painful code, whereafter they move on to discuss the next-most important things to improve, etc. etc.]




### Ticketing system
Most companies use some form of ticketing system: Jira, Trello, Github, Gitlab or another.

#### Work in a ticket-first manner
When working on a task, sheperd its ticket through the system. This means adopting some version of the following:

- Move the ticket from "backlog" to "in progress"
- Then open a git branch
- Work the ticket
- Open a pull request, get it reviewed, merge the code
- Now move the ticket to done.

Many companies use more ticketing "buckets" than Backlog, In progress, and Done, so the above will need to be expanded as fitting. A common Jira column for instance is "To Review" to give Product Owners an overview of the tickets that are "almost done".

#### Reduce WIP

Work-in-progress, or WIP, should be reduced as much as possible. The reason for this is:

- Context switching
- Collaboration overhead
- Planning overhead

The context switching is by far the worst culprit of the above. Whenever a developer is working on more than one task at a time, they need to spend a non-trivial amount of time wrapping their head around both the business domain, the change we are trying to do with the code, as well as the code itself. In complex domains, changes or code, this can amount to a massive amount of overhead and time wasted. Don't do it. If at all possible, work on one thing at a time.

#### Create topical git branches
Create a single git branch per ticket. Work on that single branch. Sometimes a branch cannot or should not be merged into master by itself. In this case, create a pull request to a larger "epic" branch and merge into that. Then when the Epic branch is ready to merge to master create a pull request to do so.

#### Adopt a rigid structure for branch naming
The main reason for both git and ticketing systems is collaboration. To simplify this, adopt some form of rigid structure for naming branches. This way, anyone can more easily find a branch for a ticket and a ticket for a branch. I normally use some form of the following:

```
# Structure
[board_or_project_key]-[ticket_number]-short-desription-for-clarity
```

Keep the board_or_project_key short so it is not a pain to write all the time. For instance, for Jira you often have a team board, and it makes sense to use a short version of the team name.

For example, for the CAP team and ticket number 42 with the title "Add create user POST endpoint":

```
cap-42-add-create-user-post-endpoint
```

The benefit here is that anyone looking at the ticket will instantly know pretty much what the branch is called. Even if the branch is for some reason not linked to the ticket properly. And anyone looking at the branch will be able to easily find the ticket by either the cap-42 part or the name.

### Daily stand-up

> Standups are a place to figure out if more collaboration is needed

Daily standups are a very important tool in the agile workflow. They should be kept very, very short. About one minute per participant. Standups are a place to *figure out if more collaboration is needed*. It is a place where we give a very short overview of our work. This is so other team members can figure out if they need to give input on it.

A good structure is something like the following:

- What did I do yesterday?
- What have / will I do today?
- Is anything blocking me?

#### Guarding against long stand-up discussions
Often discussions come up at stand-up. This is exactly because they are about collaboration. Most of the time this is simply something like the following:
- "I did X", "Oh nice, does this mean Y", "Yes it does".
- "I am blocked by X", "Oh, I think you should look at Y", "Nah, I already tried that, didnt work", "Ok, maybe I come by later"

The problem is when two people disagree about something important to them:

- "I think we should do X", "I think Y is better" or "I agree, but we should be X2 instead"

Then you can have a very long and heated discussion during standup.

To alleviate this problem, simply adopt the rule that it is always acceptable to ask "*hey, can we take this after standup?*".

Then, whoever has a stake in the discussion simply stays behind after standup in order to finish what they were talking about.

This should be done any time a discussion is more than five to ten sentences.

### Sprints
The main purpose of a sprint is not to scramble and rush to finish. It is to see how much work was done, so we can estimate how likely our larger deadlines are to hold water.

I have found that often upper management care more about simply knowing if a project is on track or not. If not, how much is it off?

This way we are less likely to find big scary monsters in the closet three months / one year in. We need to find those bad boys as early as possible.

This:

"Based on Sprint performance in sprints one to six, we are expecting to be one month delayed total compared to original estimates."

Is better than:

"We are behind on sprint six of sixteen by [no idea] but we are working overtime to catch up"

With the second message, we have no idea how the next sprints will look or how much the project will be delayed total. Worse, we are risking burnout and much larger delays by trying to "catch up".

Of course it is all guesswork. And that is what sprints are about: Improving our guesswork so plans can be made with higher confidence.

### Kanban or Sprints
This choice depends largely on the level of syncing up required between teams. If three different teams need to finish a single product together, then sprints are probably what you need. If a single team is largely delivering business value independently, you may want to use Kanban instead. Kanban is often a more natural way of working in programming and has much less planning overhead than the sprint structure.

## Documentation
Yes, it is a tired trope, but it is still true: Any system is only as good as its documentation.

### Be explicit
You often see things which are implicitly understood in a system. Things which people are expected to "just know". This is implicit knowledge. Some of it is fine and unavoidable of course. The problem comes when you have too much implicit knowledge. Now it is hindering progress.

Too much implicit knowledge has two dangers:
- Knowledge is forgotten / leaves the company and takes a long time to recover / reverse engineer
- Developers and users need to keep this knowledge in their head all the time while working. This leaves less room for thoughts about progress.

### Be concise
<!-- ### Documenting architecture decisions
http://thinkrelevance.com/blog/2011/11/15/documenting-architecture-decisions -->

### Have a simple high-level source of truth

> The code should not be the only source of truth

Often in companies you see that there is no "source of truth" except from the code. Jira tickets are written for each Sprint, and then left to rot and grow obscure. When a new developer asks "how should X work" the solution is to read the code. The code is the only source of truth.

This is not ideal. Everything the developers do takes longer than necessary. In order to understand what to change for a feature the developers have to talk to three different people. After they start coding they need to come back to ask "what about this edge case" because nobody had thought about it when writing the ticket. This process *somewhat* works. Most of the time. But it is slow. Very slow. And for every feature, every bug, it gets slower and slower.

Then the inevitable happens: Engineering is being labeled as slow. Business is demanding faster results. Product managers are stressed. They stress the engineers. The engineers cut corners to "deliver the sprints". Maybe sick leave in engineering starts going up. Some people go down with stress. Guess what comes next:

People. Start. Quitting.
- Senior / talented people leave

Now someone discovers a bug in the code. They suspect that flow A is not correct because they are getting weird errors downstream from it in flow B. Flow A was created three years ago and nobody working on it now works in the company anymore. It is a mess of indirection and it is a bit hard to see everything it is supposed to do.

In cases of doubt like these as to how something works, developers now have a lot of work just finding out how something should work. They have to read through 10+ files of source code, as well as dig up ancient Jira tickets to figure things out. Since it is hard to figure out *how it should work*, not how to code it, this takes up *everyone's* time: All three senior developers, as well as the product owner and two business people end up getting involved at some point. Everyone now has to context switch and spend time they should be using moving forward, on looking back.

So now a simple bug takes a very long time to fix. Not because of the actual time to build it. Because it takes a long, long time to figure out

<!-- TODO: Continue writing on this: Unfortunately, when the source of truth is left to the engineers to manage and discover all edge cases, you often also come across the notion that engineering is working slowly. -->

When you are working and evolving a mature system, it pays to keep a very simple source of truth on how things should work. The added clarity for everyone involved is worth the investment.

#### Example: Adding a new credit card

Here is a fictional example of a bank issuing a credit card for a user.

```
Creating a new personal credit card for a user.
Note: There are two types of credit card which can be created: Personal and Business.

Personal credit card creation. The system:
- Ensures that user is over 18 years old
- Ensures that user has passed KYC
- Ensures that no danger flags are set on users account
- Ensures user has entered full name
- Ensures user has entered full address so we can send card
- Ensures that user has positive account balance
- Converts users name to ISO-XYZ standard for printing
- Creates credit card record in system. Card is marked "PENDING_ISSUANCE"
- Sends request to card issuer to issue card
- If card issuer responds positive:
	- Card is marked "PENDING_ACTIVATION"
- If card issuer responds negative:
	- Card is marked "ISSUANCE_ERROR"
	- Notice is sent to cards business section to look into it
```

There is a lot going on here! It took me all of 5 minutes to write, and anyone who needs to work on anything related to issuing credit card can now easily see the high-level of what should happen when doing so.

## Tools
### Clipboard history
> Use a clipboard history manager. Even if you think you do not need it. Try it out for two weeks.

I originally stumbled upon the advice of using a clipboard history manager [from an interview with Jeff Atwood](https://lifehacker.com/5950386/im-jeff-atwood-founder-of-stack-exchange-and-this-is-how-i-work), the founder of Stack Overflow.

I had never used a Clipboard history app before. Now, 3 years later, I would not want to code without it.

The best one (as far as I know) for OSX is [Alfred with the Powerpack addon](https://www.alfredapp.com/).

## Hiring
### Getting the right people on the bus
You should hire engineers for, in order of priority:

1. Cultural fit
1. Work Ethics / Gets shit done
1. Raw intelligence
1. Specific languages / skills (e.g. Java, DevOps, CI/CD experience)

### Basic interview roadmap
Largely based on Joel Spolskys list from [The Guerrilla Guide to Interviewing (version 3.0)](https://www.joelonsoftware.com/2006/10/25/the-guerrilla-guide-to-interviewing-version-30/)
1. Introduction
1. Question about recent project candidate worked on
1. Easy Programming Question
1. Harder Programming Question
1. Are you satisfied with / How would you improve that code?
1. Let me tell you about working here
1. Do you have any questions?

### Interview process
- Ask open-ended questions. We are here to learn about the candidate
- Look for passion in the candidates answers
- Smart people can explain complicated things in a simple way
- Have they taken ownership of tasks / problems in the past?
- If there is any doubt, there is no doubt

## TODO: Topics to cover
- When brown stuff hits spinning stuff
    - Plan for accidents
    - Triage:
      - Stop the accident
      - Stop the bleeding
      - Patch the wound
    - Post-morten
- You cannot fix culture with structure
- Maximum 70% workload so you have capacity to handle the unexpected
  - Allows continuous improvement
  - Two ways engineering can go
    - Relaxed engineers
      - Code is easy to understand
      - Well tested
      - Few bugs
      - => Leads to more good / easy to understand code => Faster code and better tests => Fast tests / Fast development
    - Stressed engineers
      - Code is hard to understand
      - Few and / or slow tests
      - Many bugs
      - => Leads to more time spent fixing bugs => More bad / hard to understand code => Slow tests / Slow development
- Trust your engineers
- Provide decent workspaces for your engineers
  - Provide a quiet, calm environment for your engineers
    - Never, ever place engineering in the same room as sales
- Provide phone booth boxes
- To rewrite the code from scratch or not?
- No big changes deployed on a Friday
- Use an AppLogger to log domain events: [APPNAME][LEVEL][CALLER CLASS] msg (plus TID if log system does not show similar)
- Continuous Improvement - always leave the code a little better than you found it
