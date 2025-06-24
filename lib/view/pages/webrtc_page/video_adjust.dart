String preferH264(String sdp) {
  final lines = sdp.split('\r\n');
  int mLineIndex = -1;
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].startsWith('m=video')) {
      mLineIndex = i;
      break;
    }
  }
  if (mLineIndex == -1) return sdp;

  final RtpMap h264 = RtpMap(payloadType: -1, codec: 'H264');
  for (final line in lines) {
    if (line.contains('H264')) {
      final rtpmap = RtpMap.fromSdpLine(line);
      if (rtpmap != null) {
        h264.payloadType = rtpmap.payloadType;
        break;
      }
    }
  }
  if (h264.payloadType == -1) return sdp;

  final mLineParts = lines[mLineIndex].split(' ');
  final List<String> newMLineParts = [mLineParts[0], mLineParts[1], mLineParts[2], h264.payloadType.toString()];
  for (int i = 3; i < mLineParts.length; i++) {
    if (mLineParts[i] != h264.payloadType.toString()) {
      newMLineParts.add(mLineParts[i]);
    }
  }
  lines[mLineIndex] = newMLineParts.join(' ');
  return lines.join('\r\n');
}

class RtpMap {
  int payloadType;
  String codec;
  RtpMap({required this.payloadType, required this.codec});
  static RtpMap? fromSdpLine(String line) {
    final parts = line.split(' ');
    if (parts.length > 2 && parts[0].contains('rtpmap')) {
      final pt = int.tryParse(parts[0].split(':')[1]);
      final codec = parts[1].split('/')[0];
      if(pt != null) return RtpMap(payloadType: pt, codec: codec);
    }
    return null;
  }
}