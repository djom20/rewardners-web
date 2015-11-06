video_count =1;
videoPlayer = document.getElementById("video1");

function run(){
  video_count++;
  if (video_count == 4) video_count = 1;
  var nextVideoFallback = "http://s3.amazonaws.com/rewardners-pr/videos/business/banner"+video_count+".jpg";
  var nextVideoMp4 = "http://s3.amazonaws.com/rewardners-pr/videos/business/banner"+video_count+".mp4";
  var nextVideoOgg = "http://s3.amazonaws.com/rewardners-pr/videos/business/banner"+video_count+".ogg";
  var nextVideoWebm = "http://s3.amazonaws.com/rewardners-pr/videos/business/banner"+video_count+".webm";
  var nextCover = "http://s3.amazonaws.com/rewardners-pr/videos/business/banner"+video_count+".jpg";
  var mp4Vid = document.getElementById("mp4Source");
  var oggVid = document.getElementById("oggSource");
  var webmVid = document.getElementById("webmSource");
  var fallback = document.getElementById("home");
  videoPlayer.pause();
  videoPlayer.poster = nextCover;
  $(mp4Vid).attr('src', nextVideoMp4);
  $(oggVid).attr('src', nextVideoOgg);
  $(webmVid).attr('src', nextVideoWebm);
  fallback.style.backgroundImage =  'url(' + nextVideoFallback + ')';
  videoPlayer.load();
  videoPlayer.play();
};
