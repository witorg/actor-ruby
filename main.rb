require 'actor'

person = {
  id:         'be213113ff332ea21324',
  gender:     'Male',
  last_name:  'Doe',
  first_name: 'John',
}

class Action
  class << self
    def call
      instance = nil

      retries.times do
        perform(instance)
      end
    end

    def perform(instance)
      instance.call(inputs)
    rescue exceptions
      # Do something with error
    end
  end

  def warn!
  end

  def success!
  end

  def fail!
  end

  def log!
  end
end

class CreateData < Action
  retries 2 # Default retry value

  exceptions StandardError, EOFError, NameError # Always the same based on call logic

  input :id, optional: [ :name ]

  def call
    success!(data)
    fail!(error)
    warn!(message)
    log!()
  end
end

CreateData.call(input: {}, options: { retries: 6 })
