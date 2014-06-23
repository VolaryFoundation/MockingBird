rivets.adapters[':'] = {
  subscribe: function(obj, keypath, callback) {
    obj.on('change:' + keypath, callback)
  },
  unsubscribe: function(obj, keypath, callback) {
    obj.off('change:' + keypath, callback)
  },
  read: function(obj, keypath) {
    return obj.get(keypath)
  },
  publish: function(obj, keypath, value) {
    obj.set(keypath, value)
  }
}

rivets.configure({
  handler: function(target, event, binding) {
    this.call(binding.model, event, binding.view.models)
  }
})

rivets.formatters.asAddress = function(val) {
  if (!val) return ''
  return val.address + '<br />' + val.city + ', ' + val.state
}

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
//
