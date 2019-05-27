# frozen_string_literal: true

RSpec.describe Doomfire::Terminal do
  let!(:terminal) { Doomfire::Terminal.new }
  before { RUBY_PLATFORM = 'windows' }

  describe '#clear_screen' do
    let(:output) { capture(:stdout) { terminal.send(:clear_screen) } }

    it 'prints clear control sequences' do
      expect(output).to include "\e[2J\n\e[H\n"
    end
  end

  describe '#clear' do
    let(:output) { capture(:stdout) { terminal.send(:clear) } }

    it 'prints clear control sequences' do
      expect(output).to include "\e[34f\e[f"
    end
  end

  describe '#stop' do
    it 'sets the exit variable to true' do
      terminal.stop
      expect(terminal.exit_requested).to eq true
    end
  end

  describe '#initialize_pixels' do
    it 'sets up starting array' do
      terminal.send(:initialize_pixels)
      expect(terminal.pixels.pop(80)).to eq [].fill(34, 0, 80)
      expect(terminal.pixels.shift(80 * 33)).to eq [].fill(0, 0, 80 * 33)
    end
  end

  describe '#update_pixels' do
    it 'updates pixels array' do
      terminal.send(:update_pixels)

      expect(terminal.pixels.pop(80)).to eq [].fill(34, 0, 80)
      expect(terminal.pixels.shift(80 * 33)).not_to eq [].fill(0, 0, 80 * 33)
    end
  end
end
