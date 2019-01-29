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

The problem is when two people disagree about something important to them. Then you can have a very long and heated discussion during standup.
To alleviate this problem, simply adopt the rule that it is always acceptable to ask *"hey, can we take this after standup?"*. Then, whoever has a stake in the discussion simply stays behind after standup in order to finish what they were talking about. This should be done any time a discussion is more than five to ten sentences.

### Documentation

Any system is only as good as its documentation.

<!-- #### Be explicit -->
<!-- #### Documenting architecture decisions
http://thinkrelevance.com/blog/2011/11/15/documenting-architecture-decisions -->

<!-- ### Books

- DDD: Eric Evans, Domain Drive Design. [O'Reilly](https://www.oreilly.com/library/view/domain-driven-design-tackling/0321125215/)
- Getting Real
- https://www.amazon.com/Smart-Gets-Things-Done-Technical/dp/1590598385
- https://www.amazon.de/dp/0066620996/ref=asc_df_006662099657912267/?tag=googshopde-21&creative=22398&creativeASIN=0066620996&linkCode=df0&hvadid=310779890634&hvpos=1o1&hvnetw=g&hvrand=10823028277884438276&hvpone=&hvptwo=&hvqmt=&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=1003854&hvtargid=pla-425752468924&th=1&psc=1&tag=&ref=&adgrpid=70301320708&hvpone=&hvptwo=&hvadid=310779890634&hvpos=1o1&hvnetw=g&hvrand=10823028277884438276&hvqmt=&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=1003854&hvtargid=pla-425752468924 -->

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

#### Interview process
- If there is any doubt, there is no doubt