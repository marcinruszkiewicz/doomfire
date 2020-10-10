# frozen_string_literal: true

RSpec.describe Doomfire::WindowSize do
  let(:sizer) { Doomfire::WindowSize.new }

  describe '#terminal_width' do
    context 'unknown terminal' do
      before { allow(RbConfig::CONFIG).to receive(:[]).with('host_os').and_return('windows') }

      it 'returns 80 on unknown terminals' do
        expect(sizer.terminal_width).to eq 80
      end
    end
  end
end
