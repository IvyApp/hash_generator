class HashGenerator
  VERSION = '1.0.0'

  def initialize
    @value = @scope = {}
    @stack = []
  end

  def end_scope
    @scope = @stack.pop
  end

  def new_array
    begin_scope([])
  end

  def new_object
    begin_scope({})
  end

  def push_object
    new_object
    yield
    push_scope
  end

  def push_scope
    value = @scope
    end_scope
    push(value)
  end

  def reopen_scope(key)
    begin_scope(@scope.fetch(key))
  end

  def store(key, value)
    @scope.store(key, value)
  end

  def store_array(key)
    new_array
    yield
    store_scope(key)
  end

  def store_object(key)
    new_object
    yield
    store_scope(key)
  end

  def store_scope(key)
    value = @scope
    end_scope
    store(key, value)
  end

  def to_h
    @value
  end

  alias to_hash to_h

  private

  def begin_scope(scope)
    @stack.push(@scope)
    @scope = scope
  end

  def push(value)
    @scope.push(value)
  end
end
