class ProcuringDataSupplierTask

  include Sidekiq::Worker
  sidekiq_options retry: 3, lock: :while_executing, on_conflict: :reject

  def perform
    # NOTE: I assume in a real project, we will think about another
    # mechanism to fetch the hotel supplier data. But in this case,
    # I just apply the simple case for only test purpose
    MergingServices::Hotel::Procuring.new.execute
  end

end