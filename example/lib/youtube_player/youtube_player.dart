import 'package:angular/angular.dart';
import '../component_info/component_info.dart';
import '../section/section.dart';

@Component(
    selector: 'youtube-player',
    templateUrl: 'youtube_player.html',
    directives: [ComponentInfo, Section])
class YoutubePlayer {
  final String htmlDefault = '''  
<p> CONTENT HERE </p>''';
}
