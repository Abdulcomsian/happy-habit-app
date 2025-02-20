import 'package:audioplayers/audioplayers.dart';
import 'package:happy_habit/core/constants/asset_paths.dart';
import 'package:happy_habit/core/extensions/string_extensions.dart';
import 'package:happy_habit/core/services/logger.dart';

// Enum for the source type (URL or Asset)
enum MusicSource { asset, url }

class MusicServices {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  static Future<void> play(String url, {MusicSource source = MusicSource.url}) async {
    try {
      // Stop any currently playing music
      await _audioPlayer.stop();

      switch (source){
        case MusicSource.url:
        // Play the specified music file at normal volume
          await _audioPlayer.play(UrlSource(url), volume: 1.0, mode: PlayerMode.mediaPlayer);
          break;
        case MusicSource.asset:
        // Play the specified music file at normal volume
          await _audioPlayer.play(AssetSource(url), volume: 1.0, mode: PlayerMode.mediaPlayer);
          break;
      }

      // Ensure looping
      _audioPlayer.setReleaseMode(ReleaseMode.loop);
      Logger.logSuccess("Playing ${url.basenameWithoutExtension()} music");
    } catch (e) {
      Logger.logError("Error playing music: $e");
    }
  }

  /// Plays a short success sound for 3 seconds
  static Future<void> playSuccessMusic() async {
    try {
      await _audioPlayer.stop(); // Stop any currently playing sound
      await _audioPlayer.play(AssetSource(AppMusics.success),
          volume: 1.0, mode: PlayerMode.mediaPlayer);
      Logger.logSuccess('Playing success music');

      // Stop music after 3 seconds
      await Future.delayed(Duration(milliseconds: 1500));
      await _audioPlayer.stop();
    } catch (e) {
      Logger.logError("Error playing success sound: $e");
    }
  }

  static Future<void> stop() async => await _audioPlayer.stop();
}
