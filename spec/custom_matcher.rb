RSpec::Matchers.define :accept_values_for do |attribute, *values|
  match do |model|
    values.all? do |value|
      model.send("#{attribute}=", value)
      model.valid?
    end
  end

  failure_message_for_should do |model|
    "#{model.class}.#{attribute} should accept #{values}"
  end
end

RSpec::Matchers.define :not_accept_values_for do |attribute, *values|
  match do |model|
    values.all? do |value|
      model.send("#{attribute}=", value)
      !model.valid?
    end
  end

  failure_message_for_should do |model|
    "#{model.class}.#{attribute} should not accept #{values}"
  end
end
