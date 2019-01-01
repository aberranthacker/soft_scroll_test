# https://github.com/bordeeinc/bmp-ruby
bmp = File.binread('rebels.bmp')

offset = bmp[0xA, 4].unpack('V')[0] # little endian, LSB goes first
bitmap = bmp[offset..-1].bytes.reverse

# 4-bits color, 2 pixels/byte
(0...bitmap.length).step(160).each do |idx|
  bitmap[idx,160] = bitmap[idx, 160].reverse
end

bps_bmp = []
lsb = 0
msb = 0
bitmap.each.with_index do |byte, idx|
  pix_pair_idx = idx % 4 * 2

  if pix_pair_idx.zero? && idx > 0
    bps_bmp << lsb
    bps_bmp << msb
    lsb = 0
    msb = 0
  end

  dot0 = (byte & 0b00110000) >> 4
  dot1 = (byte & 0b00000011)

  dot0_lsb = (dot0 & 0b01)
  dot0_msb = (dot0 & 0b10) >> 1

  dot1_lsb = (dot1 & 0b01)
  dot1_msb = (dot1 & 0b10) >> 1

  lsb |= dot0_lsb << (pix_pair_idx)
  msb |= dot0_msb << (pix_pair_idx)

  lsb |= dot1_lsb << (pix_pair_idx+1)
  msb |= dot1_msb << (pix_pair_idx+1)
end

bps_bmp = bps_bmp.map(&:chr).join

File.binwrite('rebels.bps', bps_bmp)
