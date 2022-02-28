class ProcuringTask < ApplicationRecord

  enum state: {
    initial:     0,
    in_progress: 1,
    done:        2
  }.freeze

end