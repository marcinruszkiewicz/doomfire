# frozen_string_literal: true

RSpec.describe Doomfire::Base do
  let!(:base) { Doomfire::Base.new }

  context 'public methods' do
    describe '#run' do
      it 'raises NotImplementedError' do
        expect { base.run }.to raise_error NotImplementedError
      end
    end

    describe '#stop' do
      it 'raises NotImplementedError' do
        expect { base.stop }.to raise_error NotImplementedError
      end
    end
  end

  context 'private methods' do
    describe '#initialize_pixels' do
      it 'sets up starting array' do
        base.send(:initialize_pixels)
        expect(base.pixels.pop(80)).to eq [].fill(34, 0, 80)
        expect(base.pixels.shift(80 * 33)).to eq [].fill(0, 0, 80 * 33)
      end
    end

    describe '#update_pixels' do
      # last element is sometimes 0
      xit 'updates pixels array' do
        base.send(:update_pixels)

        expect(base.pixels.pop(80)).to eq [].fill(34, 0, 80)
        expect(base.pixels.shift(80 * 33)).not_to eq [].fill(0, 0, 80 * 33)
      end
    end

    describe '#stop_fire' do
      it 'clears last line of pixels array' do
        base.send(:stop_fire)
        expect(base.pixels.pop(80)).to eq [].fill(0, 0, 80)
      end
    end

    describe '#prepare_output' do
      it 'sets default width to 80' do
        base.send(:prepare_output)
        expect(base.fire_width).to eq 80
      end
    end

    describe '#clear' do
      it 'raises NotImplementedError' do
        expect { base.send(:clear) }.to raise_error NotImplementedError
      end
    end

    describe '#clear_screen' do
      it 'raises NotImplementedError' do
        expect { base.send(:clear_screen) }.to raise_error NotImplementedError
      end
    end

    describe '#fire_loop' do
      it 'raises NotImplementedError' do
        expect { base.send(:fire_loop) }.to raise_error NotImplementedError
      end
    end

    describe '#print_pixels' do
      it 'raises NotImplementedError' do
        expect { base.send(:print_pixels) }.to raise_error NotImplementedError
      end
    end
  end
end
