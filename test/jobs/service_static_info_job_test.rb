require 'test_helper'

class ServiceStaticInfoJobTest < ActiveJob::TestCase
   static = ServiceStaticInfoJob.new
  #test "the truth" do
    static.perform_now
    # if sta  assert true 
  #end
end
