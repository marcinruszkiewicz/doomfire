# frozen_string_literal: true

RSpec.describe Doomfire::WindowSize do
  let(:sizer) { Doomfire::WindowSize.new }

  describe '#terminal_width' do
    context 'unknown terminal' do
      before { RUBY_PLATFORM = 'windows' }

      it 'returns 80 on unknown terminals' do
        expect(sizer.terminal_width).to eq 80
      end
    end
  end
end
