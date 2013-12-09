var pieces = {
  timeago: function (container) { $(container).timeago(); }
};

var piecemaker = new Piecemaker({namespace: pieces});
piecemaker.setup();
