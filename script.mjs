WorkerScript.onMessage = function(message) {
//    console.log(message.msg);
    WorkerScript.sendMessage({ 'reply': message.msg});
}
