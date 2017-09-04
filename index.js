const go_program = "./main"
const child_process = require('child_process');

exports.handler = function(event, context, callback) {
  var process = child_process.spawn(go_program, [ JSON.stringify(event) ], { stdio: 'inherit' });

  process.on('close', function(code) {
    if(code !== 0) {
      return callback(null, new Error("Processs Exited"));
    }

    callback(null, "Successfully Executed");
  });
}
