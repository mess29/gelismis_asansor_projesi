import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class AudioVisualNotesWidget extends StatefulWidget {
  final Function(List<String> audioPaths, List<String> photoPaths)? onChanged;

  const AudioVisualNotesWidget({super.key, this.onChanged});

  @override
  State<AudioVisualNotesWidget> createState() => _AudioVisualNotesWidgetState();
}

class _AudioVisualNotesWidgetState extends State<AudioVisualNotesWidget> {
  final AudioRecorder _audioRecorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final ImagePicker _picker = ImagePicker();

  bool _isRecording = false;
  String? _currentlyPlayingPath;
  bool _isPlaying = false;

  final List<String> _voiceNotePaths = [];
  final List<String> _photoPaths = [];

  @override
  void dispose() {
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _toggleRecording() async {
    try {
      if (_isRecording) {
        final path = await _audioRecorder.stop();
        if (path != null) {
          setState(() {
            _isRecording = false;
            _voiceNotePaths.add(path);
          });
          widget.onChanged?.call(_voiceNotePaths, _photoPaths);
        }
      } else {
        if (await _audioRecorder.hasPermission()) {
          final dir = await getApplicationDocumentsDirectory();
          final filePath = '${dir.path}/voice_${DateTime.now().millisecondsSinceEpoch}.m4a';
          await _audioRecorder.start(const RecordConfig(), path: filePath);
          setState(() {
            _isRecording = true;
          });
        }
      }
    } catch (e) {
      debugPrint('Ses kaydı hatası: $e');
    }
  }

  Future<void> _playVoiceNote(String path) async {
    if (_isPlaying && _currentlyPlayingPath == path) {
      await _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
      });
    } else {
      await _audioPlayer.stop();
      await _audioPlayer.play(DeviceFileSource(path));
      setState(() {
        _currentlyPlayingPath = path;
        _isPlaying = true;
      });
      _audioPlayer.onPlayerComplete.listen((_) {
        if (mounted) {
          setState(() {
            _isPlaying = false;
            _currentlyPlayingPath = null;
          });
        }
      });
    }
  }

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera, imageQuality: 85);
    if (photo != null) {
      setState(() {
        _photoPaths.add(photo.path);
      });
      widget.onChanged?.call(_voiceNotePaths, _photoPaths);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Sesli & Görsel Saha Notları',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                IconButton.filledTonal(
                  onPressed: _toggleRecording,
                  icon: Icon(_isRecording ? Icons.stop : Icons.mic),
                  color: _isRecording ? Colors.red : theme.colorScheme.primary,
                  tooltip: _isRecording ? 'Kaydı Durdur' : 'Ses Notu Al',
                ),
                const SizedBox(width: 8),
                IconButton.filledTonal(
                  onPressed: _takePhoto,
                  icon: const Icon(Icons.camera_alt),
                  tooltip: 'Fotoğraf Çek',
                ),
              ],
            ),
          ],
        ),
        if (_isRecording) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.red),
            ),
            child: Row(
              children: const [
                Icon(Icons.fiber_manual_record, color: Colors.red),
                SizedBox(width: 10),
                Text(
                  'Ses Kaydediliyor... (Konuşabilirsiniz)',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
        if (_voiceNotePaths.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text('Ses Notları (${_voiceNotePaths.length})', style: theme.textTheme.bodySmall),
          const SizedBox(height: 6),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _voiceNotePaths.length,
            itemBuilder: (context, index) {
              final path = _voiceNotePaths[index];
              final isCurrent = _currentlyPlayingPath == path && _isPlaying;
              return Card(
                elevation: 1,
                child: ListTile(
                  leading: IconButton(
                    icon: Icon(isCurrent ? Icons.pause_circle_filled : Icons.play_circle_fill),
                    iconSize: 32,
                    color: theme.colorScheme.primary,
                    onPressed: () => _playVoiceNote(path),
                  ),
                  title: Text('Sesli Not ${index + 1}'),
                  subtitle: Text(path.split('/').last),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        _voiceNotePaths.removeAt(index);
                      });
                      widget.onChanged?.call(_voiceNotePaths, _photoPaths);
                    },
                  ),
                ),
              );
            },
          ),
        ],
        if (_photoPaths.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text('Çekilen Fotoğraflar (${_photoPaths.length})', style: theme.textTheme.bodySmall),
          const SizedBox(height: 6),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _photoPaths.length,
              itemBuilder: (context, index) {
                final path = _photoPaths[index];
                return Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: FileImage(File(path)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 14,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _photoPaths.removeAt(index);
                          });
                          widget.onChanged?.call(_voiceNotePaths, _photoPaths);
                        },
                        child: const CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.black54,
                          child: Icon(Icons.close, size: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}
