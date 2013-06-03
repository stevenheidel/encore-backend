require 'zeus/rails'

class CustomPlan < Zeus::Rails

  def after_fork
    srand
    super
  end

end

Zeus.plan = CustomPlan.new
