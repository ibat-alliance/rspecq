require "rspec/core"

module RSpecQ
  # If a worker haven't executed an example for more than WORKER_LIVENESS_SEC
  # seconds, it is considered dead and its reserved work will be put back
  # to the queue to be picked up by another worker.
  #
  # Override via RSPECQ_WORKER_LIVENESS_SEC for suites with individual
  # examples that legitimately run long under CI resource contention -
  # otherwise the reclaim can fire on a worker that's still working,
  # reassigning the same job repeatedly (this reclaim path has no
  # requeue cap, unlike a requeue on failure).
  WORKER_LIVENESS_SEC = Float(ENV.fetch("RSPECQ_WORKER_LIVENESS_SEC", 60.0))
end

require_relative "rspecq/formatters/example_count_recorder"
require_relative "rspecq/formatters/failure_recorder"
require_relative "rspecq/formatters/job_timing_recorder"
require_relative "rspecq/formatters/worker_heartbeat_recorder"

require_relative "rspecq/queue"
require_relative "rspecq/reporter"
require_relative "rspecq/version"
require_relative "rspecq/worker"
require_relative "rspecq/supervisor"
