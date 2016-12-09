require 'test_plugin_helper'

module ForemanOvm
  class OvmTest < ActiveSupport::TestCase
    should validate_presence_of(:username)
    should validate_presence_of(:password)
    #should have_one(:key_pair)

    setup { Fog.mock! }
    teardown { Fog.unmock! }

    test 'ssh key pair gets created after its saved' do
      ovm = FactoryGirl.build(:ovm_cr)
      #ovm.expects(:setup_key_pair)
      ovm.save
    end
  end
end
