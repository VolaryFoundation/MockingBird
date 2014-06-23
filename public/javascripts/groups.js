
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

//=========================================================================//
// This file is part of MockingBird.                                       //
//                                                                         //
// MockingBird is Copyright 2014 Volary Foundation and Contributors        //
//                                                                         //
// MockingBird is free software: you can redistribute it and/or modify it  //
// under the terms of the GNU Affero General Public License as published   //
// by the Free Software Foundation, either version 3 of the License, or    //
// at your option) any later version.                                      //
//                                                                         //
// MockingBird is distributed in the hope that it will be useful, but      //
// WITHOUT ANY WARRANTY; without even the implied warranty of              //
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU       //
// Affero General Public License for more details.                         //
//                                                                         //
// You should have received a copy of the GNU Affero General Public        //
// License along with MockingBird.  If not, see                            //
// <http://www.gnu.org/licenses/>.                                         //
//=========================================================================//
