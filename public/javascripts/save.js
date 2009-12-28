var canvas, c, canvastemp, ctemp, canvassel, csel, canvasundo, cundo, wsp, imgd, co, check;
var iface = { dragging:false, resizing:false, status:null, xy:null, txy:null }
var prefs = { pretty:false, controlpoints:false }



function save(onserver) {

    if(canvas.toDataURL) {

        var dataurl = canvas.toDataURL();

        if(onserver == true) {
            saveonline(dataurl);
        } else {
            overlay('Please right-click/save-as to save your drawing. <a href="#" onclick="overlay_hide()">close</a><br /><img src="'+dataurl+'" title="Please right-click/save-as" />');
        }

    } else {
        alert('Sorry, your browser does not implement the toDataURL() method required to save images.');
    }
}


function saveonline(dataurl) {

    var req = null;
    iface.status.innerHTML="Saving to server...";

    if (window.XMLHttpRequest) {
        req = new XMLHttpRequest();
        //if (req.overrideMimeType) { req.overrideMimeType('text/xml'); }
    } else {
        return;
    }

    req.onreadystatechange = function() {
        if(req.readyState == 4) {
            if(req.status == 200) {
                var response = req.responseText;
                overlay('Your image has been saved as <input size="50" value="http://canvaspaint.org/'+response+'"> <a href="#" onclick="overlay_hide()">close</a><br /><img src="http://canvaspaint.org/'+response+'" />');
            }else {
                iface.status.innerHTML="Post error code " + req.status + " " + req.statusText;
            }
        }
    };
    req.open("POST", "save.php", true);
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    req.send('u='+dataurl);

}

function overlay(content) {
    var obg = document.getElementById('overlaybg');
    obg.style.display='block';
    var o = document.getElementById('overlay');
    o.innerHTML = content;
    o.style.display = 'block';
}
function overlay_hide() {
    var o = document.getElementById('overlay');
    o.innerHTML = '';
    o.style.display = 'none';
    document.getElementById('overlaybg').style.display = 'none';
}