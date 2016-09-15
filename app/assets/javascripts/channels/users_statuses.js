App.users_statuses = App.cable.subscriptions.create("UsersStatusesChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {}
});
