## Work guide
<!-- https://guides.github.com/features/mastering-markdown/ -->


### Coding

#### Get to the first production version with as little effort as possible
Right now I may *think* I know what I am doing. However, I really do not. For this reason, I should get to the first version with as little effort as possible. This means I should build the first production version of any project with (in order of importance):

##### As simple code as possible (simple beats DRY)
Simple code beats clever code - this is doubly true for the first version! Clever code may be easier to extend / adapt, but it is harder to *fundamentally* change. The likelihood is very high that I will have to fundamentally change the first version of any project.

##### As little code as possible
Right now I may *think* I know what I am doing, but *I really don't*. Therefore I should get to the first version with as little effort as possible. This means I should not waste time on clever code.

Get to the first version with as little effort as possible.

### Collaboration

#### Ubiquitous language
##### What is it?
In the words of [Martin Fowler](https://martinfowler.com/bliki/UbiquitousLanguage.html): "the practice of building up a common, rigorous language between developers and users".

To put it more plainly: 

> A company must always ensure that developers use the same names and words to describe the business concepts as your developers.

##### Why is it so important?
One of my key takeaways from the amazing [DDD book](https://www.oreilly.com/library/view/domain-driven-design-tackling/0321125215/) is that an Ubiquitous Language is one of the most important things to create and maintain in a software company. The reason for this is that without a Ubiquitous Language, developers and business people need to constantly mentally translate terms when communicating with each other. It makes it harder for each side to understand each other. It fosters silos between business and dev. 

I have worked in companies where there was no Ubiquitous Language. Terms for important domain concepts had drifted twice between business and dev. "Campaign" in code meant either "Project" or "Advertisement" when talking to business. It confused everybody: Leadership, Sales, Product, and Development. It was the largest source of confusion for new developers. And because it had not been handled from the start, it was now a monumental effort to fix in code.

##### How do you achieve it?
By making it an explicit requirement. And then doing the work to ensure it happens and stays that way:
- Have a regular work task to make sure Dev is still in sync with business on terms.
- If a term changes in business or is wrong in dev for whatever reason, change it.
- Changing terms used in code should be a separate ticket in its own right. It is important work, not an afterthought.

#### Reviewing pull requests
##### Always be polite and friendly
A pull request is a place for friendly collaboration. It is not a battleground. Always be nice and friendly to each other.

##### Misunderstandings can very easily happen
Remember, it is very easy for misunderstandings to happen over a text-based medium. Something you write in a slightly annoyed tone might be read as a fiery insult by the receiver. Just dont do it.

Strong disagreements happen. It is best to solve these face-to-face, else over the phone, or lastly via synchronous chat. 

Come to the best agreement you can. Then respectfully describe the different viewpoints and what the outcome of the discussion was.

Jokes are of course okay, but should be used with caution. This is also because of the risk of misunderstandings.

### Agile
Agile is such an integral part of our work life today that it deserves its own section.

#### Regular retrospectives
Retrospectives are in my opinion the most important part of Agile. 

Retrospectives is the time we take to not just work but *improve how we work*. If your team was a saw, retrospectives is the time you take to sharpen that saw.

Retrospectives should be held once every sprint or every two weeks. This fits with most sprint schedules, either every halfway or at sprint end.

Even if your team uses none of the other parts of Agile, adopt regular retrospectives.

##### Main purposes
- Improve team collaboration
- Remove team roadblocks
- Having a space to bring up issues which need to be brought higher up the chain
- Letting team members vent their issues
- Celebrate successes
- Practive gratitude
    - A proven way to increase happines, which is a proven way to increase productivity

##### Attendees
- The entire team, both developers, product owners and direct manager if there is one
- A retrospective coach

Note: For this section I will assume a team size of maximum six people. If more people, you will need to adjust as needed.

##### Tools
- A big board or wall
- Lots of post-its
- Semi-fat permanent markers

##### Rules
It is okay to disagree, but we must always be courteous and nice to each other.

##### Process
The team members will be answering three questions:

###### Topics
1. What went well?
1. What did not go so well?
1. How can we improve?

###### Topic process
1. Everyone writes down topic answers
1. Each team member presents their answers
1. Answers are grouped
1. Each team member rates the groupings
1. The groupings are discussed, starting with highest rated

The coach points to the first question "What went well" and asks the team to write down at least three answers. The team should have at least five minutes for this. 

After the time is up, every team member presents their answers *and why they feel it is important*. Nobody else comments, unless it is to clarify the meaning. 

Once every team member has done this, answers are grouped so common themes emerge where possible: "Deployment issues" and "The servers crashed again" might be grouped together since both are about servers / devops. "User onboarding is a pain to change" and "Welcome emails are a mess" might also be grouped since both have to do with technical debt regarding the new user flow.

What groupings to use is very dependent on the business domain and specific team issues. The team will make their own sense of the answers.

After answers have been grouped, each team member states what they find important by placing 3-5 dots on one or more groupings. This way the team votes on what is the main issues according to them.

Once answers are voted on, they are discussed as time and energy allows, starting with the ones voted most important.


#### Ticketing system
Most companies use some form of ticketing system: Jira, Trello, Github, Gitlab or another.

##### Work in a ticket-first manner
When working on a task, sheperd its ticket through the system. This means adopting some version of the following:

- Move the ticket from "backlog" to "in progress"
- Then open a git branch
- Work the ticket
- Open a pull request, get it reviewed, merge the code
- Now move the ticket to done.

Many companies use more ticketing "buckets" than Backlog, In progress, and Done, so the above will need to be expanded as fitting. A common Jira column for instance is "To Review" to give Product Owners an overview of the tickets that are "almost done".

##### Reduce WIP
Work-in-progress, or WIP, should be reduced as much as possible. The reason for this is:

- Context switching
- Collaboration overhead
- Planning overhead

The context switching is by far the worst culprit of the above. Whenever a developer is working on more than one task at a time, they need to spend a non-trivial amount of time wrapping their head around both the business domain, the change we are trying to do with the code, as well as the code itself. In complex domains, changes or code, this can amount to a massive amount of overhead and time wasted. Don't do it. If at all possible, work on one thing at a time. 

##### Create topical git branches
Create a single git branch per ticket. Work on that single branch. Sometimes a branch cannot or should not be merged into master by itself. In this case, create a pull request to a larger "epic" branch and merge into that. Then when the Epic branch is ready to merge to master create a pull request to do so.

##### Adopt a rigid structure for branch naming
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

#### Daily stand-up
Daily standups are a very important tool in the agile workflow. They should be kept very, very short. About one minute per participant. Standups are a place to *figure out if more collaboration is needed*. It is a place where we give a very short overview of our work. Thisd is so other team members can figure out if they need to give input on it.

A good structure is something like the following:

- What did I do yesterday?
- What have / will I do today?
- Is anything blocking me?

##### Guarding against long stand-up discussions
Often discussions come up at stand-up. This is exactly because they are about collaboration. Most of the time this is simply something like the following:
- "I did X", "Oh nice, does this mean Y", "Yes it does".
- "I am blocked by X", "Oh, I think you should look at Y", "Nah, I already tried that, didnt work", "Ok, maybe I come by later"

The problem is when two people disagree about something important to them:

- "I think we should do X", "I think Y is better" or "I agree, but we should be X2 instead"

Then you can have a very long and heated discussion during standup.

To alleviate this problem, simply adopt the rule that it is always acceptable to ask "*hey, can we take this after standup?*". 

Then, whoever has a stake in the discussion simply stays behind after standup in order to finish what they were talking about. 

This should be done any time a discussion is more than five to ten sentences.

#### Sprints
An important note about sprints:

> The purpose of sprints is to improve our guesswork so plans can be made with higher confidence

The main purpose of a sprint is not to scramble and rush to finish. It is to see how much work was done, so we can estimate how likely our larger deadlines are to hold water. 

I have found that often upper management care more about simply knowing if a project is on track or not. If not, how much is it off?

This way we are less likely to find big scary monsters in the closet three months / one year in. We need to find those bad boys as early as possible.

This:

"Based on Sprint performance in sprints one to six, we are expecting to be one month delayed total compared to original estimates." 

Is better than:

"We are behind on sprint six of sixteen by [no idea] but we are working overtime to catch up"

With the second message, we have no idea how the next sprints will look or how much the project will be delayed total. Worse, we are risking burnout and much larger delays by trying to "catch up".

Of course it is all guesswork. And that is what sprints are about: Improving our guesswork so plans can be made with higher confidence.

#### Kanban or Sprints
This choice depends largely on the level of syncing up required between teams. If three different teams need to finish a single product together, then sprints are probably what you need. If a single team is largely delivering business value independently, you may want to use Kanban instead. Kanban is often a more natural way of working in programming and has much less planning overhead than the sprint structure.

### Documentation
Yes, it is a tired trope, but it is still true:

> Any system is only as good as its documentation.

#### Be explicit
You often see things which are implicitly understood in a system. Things which people are expected to "just know". This is implicit knowledge. Some of it is fine and unavoidable of course. The problem comes when you have too much implicit knowledge. Now it is hindering progress. 

Too much implicit knowledge has two dangers:
- It is forgotten and takes a long time to recover / reverse engineer
- Developers and users need to keep this knowledge in their head all the time while working. This leaves less room for thoughts about progress.

#### Be concise
<!-- #### Documenting architecture decisions
http://thinkrelevance.com/blog/2011/11/15/documenting-architecture-decisions -->

### Books
- [DDD: Eric Evans, Domain Drive Design](https://www.oreilly.com/library/view/domain-driven-design-tackling/0321125215/)
- [Getting Real](https://basecamp.com/books/Getting%20Real.pdf)
- [Good to Great](https://www.amazon.de/dp/0066620996)

### Tools
#### Clipboard history
> Use a clipboard history manager. Even if you think you do not need it. Try it out for two weeks.

I originally stumbled upon the advice of using a clipboard history manager [from an interview with Jeff Atwood](https://lifehacker.com/5950386/im-jeff-atwood-founder-of-stack-exchange-and-this-is-how-i-work), the founder of Stack Overflow. 

I had never used a Clipboard history app before. Now, 3 years later, I would not want to code without it. 

The best one (as far as I know) for OSX is [Alfred with the Powerpack addon](https://www.alfredapp.com/).

### Hiring
#### Getting the right people on the bus
You should hire engineers for, in order of priority:

1. Cultural fit
1. Work Ethics / Gets shit done
1. Raw intelligence
1. Specific languages / skills (e.g. Java, DevOps, CI/CD experience)

#### Basic interview roadmap
Largely based on Joel Spolskys list from [The Guerrilla Guide to Interviewing (version 3.0)](https://www.joelonsoftware.com/2006/10/25/the-guerrilla-guide-to-interviewing-version-30/)
1. Introduction
1. Question about recent project candidate worked on
1. Easy Programming Question
1. Harder Programming Question
1. Are you satisfied with / How would you improve that code?
1. Let me tell you about working here
1. Do you have any questions?

#### Interview process
- Ask open-ended questions. We are here to learn about the candidate
- Look for passion in the candidates answers
- Smart people can explain complicated things in a simple way
- Have they taken ownership of tasks / problems in the past?
- If there is any doubt, there is no doubt

### TODO: Topics to cover
- When brown stuff hits spinning stuff
    - Plan for accidents
    - Triage:
      - Stop the accident
      - Stop the bleeding
      - Patch the wound
    - Post-morten
- You cannot fix culture with structure