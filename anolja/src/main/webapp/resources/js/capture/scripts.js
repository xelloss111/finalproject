/** Start Google Chrome Canary with open -a Google\ Chrome\ Canary --args --enable-media-stream  OR enable the flag in about:flags **/

var App = {
	// Run if we do have camera support
	successCallback : function(stream) {
        console.log('yeah! camera support!');
        if(window.webkitURL) {
			App.video.src = window.webkitURL ? window.webkitURL.createObjectURL(stream) : stream;
//			App.video.src = window.URL.createObjectURL(stream);
        }
        else {
			App.video.src = stream;
        }
    },
	// run if we dont have camera support
	errorCallback : function(error) {
		alert('An error occurred while trying to get camera access (Your browser probably doesnt support getUserMedia() ): ' + error.code);
		return;
	},

	drawToCanvas : function(effect) {
		var video = App.video,
			appCtx = App.appCtx,
			canvas = App.canvas,
			i;

			appCtx.drawImage(video, 0, 0, 520,426);

			App.pixels = appCtx.getImageData(0,0,canvas.width,canvas.height);

		// Hipstergram!
		
		if (effect === 'hipster') {

			for (i = 0; i < App.pixels.data.length; i=i+4) {
				App.pixels.data[i + 0] = App.pixels.data[i + 0] * 3 ;
				App.pixels.data[i + 1] = App.pixels.data[i + 1] * 2;
				App.pixels.data[i + 2] = App.pixels.data[i + 2] - 10;
			}

			appCtx.putImageData(App.pixels,0,0);

		}

		// Blur!

		else if (effect === 'blur') {
			stackBlurCanvasRGBA('output',0,0,515,426,20);
		}

		// Green Screen

		else if (effect === 'greenscreen') {
				$(".colours").show();
					/* Selectors */
					var rmin = $('#red input.min').val();
					var gmin = $('#green input.min').val();
					var bmin = $('#blue input.min').val();
					var rmax = $('#red input.max').val();
					var gmax = $('#green input.max').val();
					var bmax = $('#blue input.max').val();

					// console.log(rmin,gmin,bmin,rmax,gmax,bmax);
					
					for (i = 0; i < App.pixels.data.length; i=i+4) {
									red = App.pixels.data[i + 0];
									green = App.pixels.data[i + 1];
									blue = App.pixels.data[i + 2];
									alpha = App.pixels.data[i + 3];

									if (red >= rmin && green >= gmin && blue >= bmin && red <= rmax && green <= gmax && blue <= bmax ) {
										App.pixels.data[i + 3] = 0;
									}
					}

					appCtx.putImageData(App.pixels,0,0);

		}
		else if(effect === 'glasses') {
			var comp = ccv.detect_objects({ "canvas" : (App.canvas),
											"cascade" : cascade,
											"interval" : 3,
											"min_neighbors" : 1 });

			// Draw glasses on everyone!
			for (i = 0; i < comp.length; i++) {
				appCtx.drawImage(App.glasses, comp[i].x, comp[i].y,comp[i].width, comp[i].height);
			}
						
		}
		else if(effect === 'rabbit') {
			App.rabbit = new Image();
			App.rabbit.src = ctx + "/resources/images/user/capture/glasses.png";
			
			var comp = ccv.detect_objects({ "canvas" : (App.canvas),
				"cascade" : cascade,
				"interval" : 3,
				"min_neighbors" : 1 });

			// Draw rabbit on everyone!
			for (i = 0; i < comp.length; i++) {
				appCtx.drawImage(App.rabbit, comp[i].x, comp[i].y,comp[i].width, comp[i].height);
			}
		}
	
					
	},

	start : function(effect) {
		$(".colours").hide();
		if(App.playing) { clearInterval(App.playing); }
		App.playing = setInterval(function() {
			App.drawToCanvas(effect);
		},50);
	},
};

App.init = function() {
	// Prep the document
	App.video = document.querySelector('video');
	
	App.glasses = new Image();
	App.glasses.src = ctx + "/resources/images/user/capture/glasses.png";

	App.canvas = document.querySelector("#output");
	App.appCtx = this.canvas.getContext("2d");


	navigator.getUserMedia = (navigator.getUserMedia ||
                            navigator.webkitGetUserMedia ||
                            navigator.mozGetUserMedia || 
                            navigator.msGetUserMedia);

	// Finally Check if we can run this puppy and go!
	if (navigator.getUserMedia) {
		navigator.getUserMedia({video : true}, App.successCallback, App.errorCallback);
	}
	 else {
 		 alert('Sorry, your browser does not support getUserMedia');
	}

	App.start("glasses");

};

App.stop = function() {
	var videoEle = document.querySelector('video');
	clearInterval(App.playing);
	$(videoEle).stop();
}


//if (document.querySelector('video')) {
//	console.log('ready!');
//	App.init();
//}


//document.addEventListener("DOMContentLoaded", function() {
//	console.log('ready!');
//	App.init();
//}, false);

