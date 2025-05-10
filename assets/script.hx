function onUpdatePost(elapsed) {
    trace(elapsed + 'Post');
}

function onUpdate(elapsed) {
    trace('pre'+elapsed);
}

function onCreate() {
    trace('PreCreate');
}

function onCreatePost() {
    trace('PostCreate');
}