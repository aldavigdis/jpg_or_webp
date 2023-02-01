# frozen_string_literal: true

RSpec.describe JpgOrWebp do
  it 'has a version number' do
    expect(JpgOrWebp::VERSION).not_to be nil
  end

  it 'defaults on using a browser that only has JPEG support' do
    j = JpgOrWebp.new
    expect(j.image_format).to eq('jpg')
  end

  it 'assumes a recent version of Chrome prefers WebP' do
    j = JpgOrWebp.new(
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 ' \
      '(KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36'
    )
    expect(j.image_format).to eq('webp')
  end

  it 'assumes Safari versions on older Mac OS X versions to require JPEG' do
    j = JpgOrWebp.new(
      'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_4_11; en) ' \
      'AppleWebKit/533.19.4 (KHTML, like Gecko) Version/4.1.3 Safari/533.19.4'
    )
    expect(j.image_format).to eq('jpg')
  end

  it 'assumes there is only JPEG support on older iOS versions' do
    j = JpgOrWebp.new(
      'Mozilla/5.0 (iPhone; CPU iPhone OS 13_0 like Mac OS X) ' \
      'AppleWebKit/605.1.15 (KHTML, like Gecko) ' \
      'Version/13.0 Mobile/15E148 Safari/604.1'
    )
    expect(j.image_format).to eq('jpg')
  end
end
