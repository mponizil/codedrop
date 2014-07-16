module.exports = (mainHost, targetHost) ->
  """
<script type='text/javascript'>
(function() {
/*!
  * domready (c) Dustin Diaz 2012 - License MIT
  */
!function (name, definition) {
  if (typeof module != 'undefined') module.exports = definition()
  else if (typeof define == 'function' && typeof define.amd == 'object') define(definition)
  else this[name] = definition()
}('domready', function (ready) {

  var fns = [], fn, f = false
    , doc = document
    , testEl = doc.documentElement
    , hack = testEl.doScroll
    , domContentLoaded = 'DOMContentLoaded'
    , addEventListener = 'addEventListener'
    , onreadystatechange = 'onreadystatechange'
    , readyState = 'readyState'
    , loadedRgx = hack ? /^loaded|^c/ : /^loaded|c/
    , loaded = loadedRgx.test(doc[readyState])

  function flush(f) {
    loaded = 1
    while (f = fns.shift()) f()
  }

  doc[addEventListener] && doc[addEventListener](domContentLoaded, fn = function () {
    doc.removeEventListener(domContentLoaded, fn, f)
    flush()
  }, f)


  hack && doc.attachEvent(onreadystatechange, fn = function () {
    if (/^c/.test(doc[readyState])) {
      doc.detachEvent(onreadystatechange, fn)
      flush()
    }
  });

  return (ready = hack ?
    function (fn) {
      self != top ?
        loaded ? fn() : fns.push(fn) :
        function () {
          try {
            testEl.doScroll('left')
          } catch (e) {
            return setTimeout(function() { ready(fn) }, 50)
          }
          fn()
        }()
    } :
    function (fn) {
      loaded ? fn() : fns.push(fn)
    })
});

  // Helper location object
  window.codedrop = {
    location: {
      host: '#{targetHost}',
      hostname: '#{targetHost}',
      origin: location.protocol + '//#{targetHost}'
    }
  };

  var targetHostPattern = new RegExp('#{targetHost}'.replace('www.', '(www.)?'));

  // Hook XHRs with absolute URLs
  var openXhr = XMLHttpRequest.prototype.open;
  XMLHttpRequest.prototype.open = function(method, url, async, user, pass) {
    console.log('[codedrop] replacing XHR url', url);
    url = url.replace(targetHostPattern, location.host);
    openXhr.call(this, method, url, async, user, pass);
  };

  // Update document.domain
  document.domain = '#{mainHost}';

  // Scan and rewrite links
  var scan = function() {
    var anchor, anchors = document.getElementsByTagName('a');
    for (var i = 0; i < anchors.length; i++) {
      anchor = anchors[i];
      anchor.href = anchor.href.replace(targetHostPattern, location.host);
    }
  }
  domready(scan);
  setInterval(scan, 5000);

  // Hook links
  window.addEventListener('click', function(e) {
    var node = e.target;
    do {
      if (node.href) {
        console.log('[codedrop] replacing a.href', node.href);
        node.href = node.href.replace(targetHostPattern, location.host);
        e.preventDefault();
        e.stopPropagation();
        break;
      }
    } while (node = node.parentNode);
  }, true);

}).call(this);
</script>
  """
