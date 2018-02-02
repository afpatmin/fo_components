import 'dart:async';
import 'dart:html';
import 'dart:js';
import 'package:angular/angular.dart';

typedef void YoutubeCallback(JsObject event);

@Component(
    selector: 'fo-youtube-player',
    styleUrls: const ['fo_youtube_player_component.scss.css'],
    templateUrl: 'fo_youtube_player_component.html'
)
class FoYouTubePlayerComponent implements AfterContentInit, OnChanges, OnDestroy
{
  FoYouTubePlayerComponent();

  @override
  void ngAfterContentInit()
  {
    if (apiLoaded) throw new StateError('Only one fo-youtube-player can be created per app');

    document.head.children.add(new ScriptElement()..src = 'https://www.youtube.com/iframe_api');
    context['onYouTubeIframeAPIReady'] = _onAPIReady;
    apiLoaded = true;
  }

  @override
  void ngOnChanges(Map<String, SimpleChange> changes)
  {
    if (changes.containsKey('videoId') && _player != null)
    {
      _player.callMethod('cueVideoById', [videoId]);
    }
  }

  @override
  void ngOnDestroy()
  {
    _onStateChangeController.close();
  }

  void _onAPIReady()
  {
    /**
     * Youtube API is ready, initialize video
     */
    _player = new JsObject(context['YT']['Player'], [elementId, params]);
  }

  void _onReady(JsObject event)
  {
  }

  void _onStateChange(JsObject event)
  {
    switch (event['data'])
    {
      case -1:
        _onStateChangeController.add('Start');
        break;

      case 0:
        _onStateChangeController.add('End');
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

  JsObject get params
  {
    final vars = <String, String>{};
    vars['fs'] = '1';
    vars['rel'] = '0';                // Show related videos at the end of playback
    vars['modestbranding'] = '0';     // Show minimal youtube branding
    vars['showinfo'] = '1';
    vars['origin'] = Uri.base.origin;
    vars['enablejsapi'] = '1';
    vars['autoplay'] = autoplay ? '1' : '0';
    final events = <String, YoutubeCallback>{};
    events['onReady'] = _onReady;
    events['onStateChange'] = _onStateChange;
    final params = <String, dynamic>{};
    params['videoId'] = videoId;
    params['playerVars'] = vars;
    params['events'] = events;

    return new JsObject.jsify(params);
  }

  final StreamController<String> _onStateChangeController = new StreamController();

  JsObject _player;

  final String elementId = 'youtube-player-container';

  @Input()
  String videoId;

  @Input()
  bool autoplay = false;

  @Output('stateChange')
  Stream<String> get stateChangeOutput => _onStateChangeController.stream;

  static bool apiLoaded = false;
}