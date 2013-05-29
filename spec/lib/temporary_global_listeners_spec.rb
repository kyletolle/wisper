require 'spec_helper'

describe Wisper::GlobalListeners do
  let(:listener_1) { double('listener') }
  let(:listener_2) { double('listener') }
  let(:publisher)  { Object.class_eval { include Wisper::Publisher } }

  describe '.with' do
    it 'globally subscribes listener for duration of given block' do

      listener_1.should_receive(:success)
      listener_1.should_not_receive(:failure)

      Wisper::TemporaryListeners.with(listener_1) do
        publisher.instance_eval { broadcast(:success) }
      end

      publisher.instance_eval { broadcast(:failure) }
    end

    it 'globally subscribes listeners for duration of given block' do

      listener_1.should_receive(:success)
      listener_1.should_not_receive(:failure)

      listener_2.should_receive(:success)
      listener_2.should_not_receive(:failure)

      Wisper::TemporaryListeners.with([listener_1, listener_2]) do
        publisher.instance_eval { broadcast(:success) }
      end

      publisher.instance_eval { broadcast(:failure) }
    end
  end
end

