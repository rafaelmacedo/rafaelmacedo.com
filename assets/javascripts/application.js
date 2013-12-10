var App = {
  components: {}
};

App.components.timeago = function() {
  function Piece(container) { $(container).timeago(); }
  return Piece;
}();

$(function() {
  var piecemaker = new Piecemaker({
    name: "components",
    namespace: App.components
  });
  piecemaker.setup();
});
