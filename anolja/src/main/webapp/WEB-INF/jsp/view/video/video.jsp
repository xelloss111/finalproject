<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/youtube.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<section class="content_section">
	<div class="content_row_1">
		<div class="container-fluid">
<div class="row-fluid">
<div class="span12">
    <div class="carousel slide" id="myCarousel">
        <div class="carousel-inner">
 
            <div class="item active">
            
                <div class="bannerImage">
                   <!--  <a href="#"><img src="http://placehold.it/960x405" alt=""></a> -->
					<a href="#"> 
						<video>
							<source src="https://www.youtube.com/embed/GG4_i38ZyZw">
						</video> 
					</a>
                </div>
                            
                <div class="caption row-fluid">
                    <div class="span4"><h3>Nullam Condimentum Nibh Etiam Sem</h3>
                    </div>                	
                	<div class="span8"><p>Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Donec sed odio dui. Etiam porta sem malesuada magna mollis euismod. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum.</p>
                	</div>
                </div>
                                                         
            </div><!-- /Slide1 --> 

            <div class="item">
            
                <div class="bannerImage">
                    <a href="#"><img src="http://placehold.it/960x405" alt=""></a>
                </div>
                            
                <div class="caption row-fluid">
                    <div class="span4"><h3>Nullam Condimentum Nibh Etiam Sem</h3>
                    </div>                	
                	<div class="span8"><p>Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Donec sed odio dui. Etiam porta sem malesuada magna mollis euismod. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum.</p>
                	</div>
                </div>
                                                         
            </div><!-- /Slide2 -->             

            <div class="item">
            
                <div class="bannerImage">
                    <a href="#"><img src="http://placehold.it/960x405" alt=""></a>
                </div>
                            
                <div class="caption row-fluid">
                    <div class="span4"><h3>Nullam Condimentum Nibh Etiam Sem</h3>
                    </div>                	
                	<div class="span8"><p>Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Donec sed odio dui. Etiam porta sem malesuada magna mollis euismod. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum.</p>
                	</div>
                </div>
                                                         
            </div><!-- /Slide2 -->                      
 
        </div>
        
        <div class="control-box">                            
            <a data-slide="prev" href="#myCarousel" class="carousel-control left">‹</a>
            <a data-slide="next" href="#myCarousel" class="carousel-control right">›</a>
        </div><!-- /.control-box -->   
                              
    </div><!-- /#myCarousel -->
        
</div><!-- /.span12 -->          
</div><!-- /.row --> 
</div><!-- /.container -->

	
	</div><!-- content_row_1 END -->
</section>
<script>
//Carousel Auto-Cycle
$(document).ready(function() {
  $('.carousel').carousel({
    interval: 6000
  })
});



//The client ID is obtained from the Google Developers Console
//at https://console.developers.google.com/.
//If you run this code from a server other than http://localhost,
//you need to register your own client ID.
var OAUTH2_CLIENT_ID = 'AIzaSyCAlK-6EnlJZ3seSOGsvS7X8Yq_GzFlT9I';
var OAUTH2_SCOPES = [
'https://www.googleapis.com/auth/youtube'
];

//Upon loading, the Google APIs JS client automatically invokes this callback.
googleApiClientReady = function() {
gapi.auth.init(function() {
 window.setTimeout(checkAuth, 1);
});
}

//Attempt the immediate OAuth 2.0 client flow as soon as the page loads.
//If the currently logged-in Google Account has previously authorized
//the client specified as the OAUTH2_CLIENT_ID, then the authorization
//succeeds with no user intervention. Otherwise, it fails and the
//user interface that prompts for authorization needs to display.
function checkAuth() {
gapi.auth.authorize({
 client_id: OAUTH2_CLIENT_ID,
 scope: OAUTH2_SCOPES,
 immediate: true
}, handleAuthResult);
}

//Handle the result of a gapi.auth.authorize() call.
function handleAuthResult(authResult) {
if (authResult && !authResult.error) {
 // Authorization was successful. Hide authorization prompts and show
 // content that should be visible after authorization succeeds.
 $('.pre-auth').hide();
 $('.post-auth').show();
 loadAPIClientInterfaces();
} else {
 // Make the #login-link clickable. Attempt a non-immediate OAuth 2.0
 // client flow. The current function is called when that flow completes.
 $('#login-link').click(function() {
   gapi.auth.authorize({
     client_id: OAUTH2_CLIENT_ID,
     scope: OAUTH2_SCOPES,
     immediate: false
     }, handleAuthResult);
 });
}
}

//Load the client interfaces for the YouTube Analytics and Data APIs, which
//are required to use the Google APIs JS client. More info is available at
//http://code.google.com/p/google-api-javascript-client/wiki/GettingStarted#Loading_the_Client
function loadAPIClientInterfaces() {
gapi.client.load('youtube', 'v3', function() {
 handleAPILoaded();
});
}









//Define some variables used to remember state.
var playlistId, nextPageToken, prevPageToken;

// After the API loads, call a function to get the uploads playlist ID.
function handleAPILoaded() {
  requestUserUploadsPlaylistId();
}

// Call the Data API to retrieve the playlist ID that uniquely identifies the
// list of videos uploaded to the currently authenticated user's channel.
function requestUserUploadsPlaylistId() {
  // See https://developers.google.com/youtube/v3/docs/channels/list
  var request = gapi.client.youtube.channels.list({
    mine: true,
    part: 'contentDetails'
  });
  request.execute(function(response) {
    playlistId = response.result.items[0].contentDetails.relatedPlaylists.uploads;
    requestVideoPlaylist(playlistId);
  });
}

// Retrieve the list of videos in the specified playlist.
function requestVideoPlaylist(playlistId, pageToken) {
  $('#video-container').html('');
  var requestOptions = {
    playlistId: playlistId,
    part: 'snippet',
    maxResults: 10
  };
  if (pageToken) {
    requestOptions.pageToken = pageToken;
  }
  var request = gapi.client.youtube.playlistItems.list(requestOptions);
  request.execute(function(response) {
    // Only show pagination buttons if there is a pagination token for the
    // next or previous page of results.
    nextPageToken = response.result.nextPageToken;
    var nextVis = nextPageToken ? 'visible' : 'hidden';
    $('#next-button').css('visibility', nextVis);
    prevPageToken = response.result.prevPageToken
    var prevVis = prevPageToken ? 'visible' : 'hidden';
    $('#prev-button').css('visibility', prevVis);

    var playlistItems = response.result.items;
    if (playlistItems) {
      $.each(playlistItems, function(index, item) {
        displayResult(item.snippet);
      });
    } else {
      $('#video-container').html('Sorry you have no uploaded videos');
    }
  });
}

// Create a listing for a video.
function displayResult(videoSnippet) {
  var title = videoSnippet.title;
  var videoId = videoSnippet.resourceId.videoId;
  $('#video-container').append('<p>' + title + ' - ' + videoId + '</p>');
}

// Retrieve the next page of videos in the playlist.
function nextPage() {
  requestVideoPlaylist(playlistId, nextPageToken);
}

// Retrieve the previous page of videos in the playlist.
function previousPage() {
  requestVideoPlaylist(playlistId, prevPageToken);
}
///////////////test
var url = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=PLSB4jUMSVNnaGj5Auw93KId3MoYxvrfNQ&key=AIzaSyCAlK-6EnlJZ3seSOGsvS7X8Yq_GzFlT9I";
var req = new XMLHttpRequest();
req.open('GET', url , true);
req.onreadystatechange = function (aEvt) {
  if (req.readyState == 4) {
     if(req.status == 200)
		var result = JSON.parse(req.responseText); 
		var items = result.items;

        for (var i = 0; i<items.length; i++){
				var vId = items[i].snippet.resourceId.videoId;
				/* var vurl = "https://www.youtube.com/watch?v=" + vId; */
				var vurl = "https://www.youtube.com/embed/" + vId;
				console.log(vurl);
				console.log(items[i].snippet.title);
				console.log(items[i].snippet.thumbnails.default.url);
        }
  }else {
      console.log("Error loading page\n");
  }
};

req.send(null);
</script>