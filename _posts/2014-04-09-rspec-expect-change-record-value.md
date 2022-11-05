I want my Ruby on Rails Rspec tests to be as clean and simple as possible. If there is a command in rspec that can test something in one simple line, then I do not want to use two lines.

Here is a real life example I came across today:

```ruby
expect(spe1.reload.trashed?).to be_true
execute
expect(spe1.reload.published?).to be_true
```

This will work, but it also uses two expect calls. I dont like this, since if the first one fails, we wont get to the second. It feels like we are testing two things at once. Luckily, there is a very clean way to test the Rspec expects to change the record value in one go:

## Rspec expect to change record value, one liner

```ruby
expect{ execute }.to change{ spe1.reload.trashed? }.from(true).to(false)
```

Now we are testing both the precondition (trashed == true) and the result (trashed == false) in one line. The important thing to note here is that the change with curly brackets is a lambda, that will get called before and after the lambda given as expect clause.

## Multiple values
What about testing multiple values this way? Say we have two records, and we expect both of their values to change:

```ruby
expect{ execute }.to change{ [spe1.reload.trashed?, spe2.reload.trashed?] }.from([true, true]).to([false, false])
```

Now we are explicitly saying: “Both spe1 and spe2 should change their trashed? value from true to false”. Me like.

## Book recommendation
Do you want to have better specs and and easier time programming? I recommend you read [Effective Testing with RSpec 3](https://amzn.to/2STR98c)

[![Effective Testing with RSpec 3](/assets/books/pragmatic_programmer_effective_testing_with_rspec3.png)](https://amzn.to/2STR98c)
