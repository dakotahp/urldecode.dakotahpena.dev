(function () {
  var input = document.getElementById('input-url');
  var output = document.getElementById('output-url');
  var btnDecode = document.getElementById('btn-decode');
  var btnEncode = document.getElementById('btn-encode');
  var mode = 'decode';

  function process() {
    var val = input.value;
    if (!val) { output.value = ''; return; }
    try {
      output.value = mode === 'decode'
        ? decodeURIComponent(val)
        : encodeURIComponent(val);
    } catch (e) {
      output.value = val;
    }
  }

  input.addEventListener('input', process);

  btnDecode.addEventListener('click', function (e) {
    e.preventDefault();
    mode = 'decode';
    btnDecode.classList.add('active');
    btnEncode.classList.remove('active');
    process();
  });

  btnEncode.addEventListener('click', function (e) {
    e.preventDefault();
    mode = 'encode';
    btnEncode.classList.add('active');
    btnDecode.classList.remove('active');
    process();
  });
}());
