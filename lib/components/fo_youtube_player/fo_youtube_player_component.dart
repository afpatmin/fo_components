import 'dart:async';
import 'dart:html';
import 'dart:js';
import 'package:angular/angular.dart';
import 'package:angular_components/material_icon/material_icon.dart';

typedef void YoutubeCallback(JsObject event);

@Component(
    selector: 'fo-youtube-player',
    styleUrls: const ['fo_youtube_player_component.css'],
    templateUrl: 'fo_youtube_player_component.html',
    directives: const [MaterialIconComponent, NgIf])
class FoYouTubePlayerComponent implements OnInit, OnChanges, OnDestroy {
  FoYouTubePlayerComponent(this._host);

  void onTouch() {
    if (playing) {
      _player.callMethod('pauseVideo');
      playing = false;
    } else {
      _player.callMethod('playVideo');
      Future.delayed(Duration(milliseconds: 200)).then((_) {
        playing = true;
      });
    }
  }

  @override
  void ngOnInit() {
    playing = autoplay;
    started = autoplay;

    _host
        .querySelector('#youtube-player-wrapper')
        .children
        .insert(0, new DivElement()..id = elementId);

    if (document.head.querySelector('#fo-youtube') == null) {
      document.head.children.add(new ScriptElement()
        ..src = 'https://www.youtube.com/iframe_api'
        ..id = 'fo-youtube');
      context['onYouTubeIframeAPIReady'] = _onAPIReady;
    } else {
      _onAPIReady();
    }
  }

  @override
  void ngOnChanges(Map<String, SimpleChange> changes) {
    if (changes.containsKey('videoId') && _player != null) {
      _player.callMethod('cueVideoById', [videoId]);
    }
  }

  @override
  void ngOnDestroy() {
    _player.callMethod('destroy');
    _onStateChangeController.close();
  }

  void _onAPIReady() {
    // Youtube API is ready, initialize video
    _player = new JsObject(context['YT']['Player'], [elementId, params]);
  }

  void _onReady(JsObject event) {}

  void _onStateChange(JsObject event) {
    if (_player == null) return;
    switch (event['data']) {
      case -1:
        _onStateChangeController.add('Start');
        started = true;
        break;

      case 0:
        _onStateChangeController.add('End');
        playing = false;
        break;

      case 1:
        _onStateChangeController.add('Play');
        break;

      case 2:
        _onStateChangeController.add('Pause');
        break;

      case 3:
        _onStateChangeController.add('Navigate');
        break;

      default:
        break;
    }
  }

  JsObject get params {
    final vars = <String, String>{};
    vars['fs'] = '1';
    vars['rel'] = '0'; // Show related videos at the end of playback
    vars['modestbranding'] = '0'; // Show minimal youtube branding
    vars['showinfo'] = '1';
    vars['origin'] = Uri.base.origin;
    vars['enablejsapi'] = '1';
    vars['autoplay'] = autoplay ? '1' : '0';
    vars['controls'] = '0';
    final events = <String, YoutubeCallback>{};
    events['onReady'] = _onReady;
    events['onStateChange'] = _onStateChange;
    final params = <String, dynamic>{};
    params['videoId'] = videoId;
    params['playerVars'] = vars;
    params['events'] = events;

    return new JsObject.jsify(params);
  }

  final StreamController<String> _onStateChangeController =
      new StreamController();

  JsObject _player;

  final String elementId = 'youtube-player-container';
  final Element _host;

  @Input()
  String videoId;

  @Input()
  bool autoplay = false;

  @Output('stateChange')
  Stream<String> get stateChangeOutput => _onStateChangeController.stream;

  bool playing = false;
  bool started = false;
}
