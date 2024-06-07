```
def assert_record_valid(record)
  valid = record.valid?
  assert valid, "Expected #{record.class} record to be valid. Had errors: #{record.errors.full_messages.join(", ")}"
end

def assert_record_invalid_with_error(record, exp_error)
  assert_not record.valid?
  errors = record.errors.full_messages.join(", ")
  assert errors.include?(exp_error), "Expected #{errors} to include #{exp_error}"
end

```