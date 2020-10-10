# frozen_string_literal: true

RSpec.describe Doomfire::Terminal do
  let!(:terminal) { Doomfire::Terminal.new }

  before { allow(RbConfig::CONFIG).to receive(:[]).with('host_os').and_return('windows') }

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
end
