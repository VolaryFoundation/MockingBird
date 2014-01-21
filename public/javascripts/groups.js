
var Group = Backbone.Model.extend({
  urlRoot: "http:///api/groups",
  initialize: function() { }
})

var Groups = Backbone.Collection.extend({
  url: '/api/groups',
  model: Group
})

var UI = Backbone.Model.extend({

  defaults: {
    editMode: false
  },

  toggleEdit: function() {
    this.set("editMode", !this.get('editMode'))
  }
})

var ui = new UI
var group = new Group

rivets.bind(document.getElementById('frame'), {
  group: group,
  ui: ui
})

new (Backbone.Router.extend({

  routes: {
    "groups/:id": "getGroup"
  },

  getGroup: function (id) {
    group.set("id", id)
    group.fetch().success(function() {
      group.on('change', function() {
        group.save(null, { patch: true, silent: true })
      })
    })
  }
}))

Backbone.history.start({ pushState: true })
