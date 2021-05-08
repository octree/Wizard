"use strict";
var window = { }

if (!window.__bridge__) {
  Object.defineProperty(window, "__bridge__", {
    enumerable: false,
    configurable: false,
    writable: false,
    value: {}
  });
}

Object.defineProperty(window.__bridge__, "VP", {
    enumerable: false,
    configurable: false,
    writable: false,
    value: {
        __cache: {},
        __index: 0,
        store: function(val) {
            const key = "v" + this.__index++;
            this.__cache[key] = val
            return key
        },

        batchStore: function(arr) {
            let that = this
            return arr.map((elt) => {
                return that.store(elt)
            })
        },

        get: function(key) {
            return this.__cache[key]
        },

        remove: function(key) {
            delete this.__cache[key]
        }
    }
});

Object.defineProperty(window.__bridge__, "Dispatcher", {
  enumerable: false,
  configurable: false,
  writable: false,
  value: {
    __count: 0,
    cache: {},
    invoke: function invoke(id, ...args) {
      var func = window.__bridge__.VP.get(id);
      func.apply(this, args);
    },
    push: function push(func) {
      return window.__bridge__.VP.store(func)
    },
    remove: function(key) {
      window.__bridge__.VP.remove(key)
    }
  }
});

Object.defineProperty(window.__bridge__, "invoke", {
  enumerable: false,
  configurable: false,
  writable: false,
  value: function(id, ...args) {
    let argMap = {};
    args.forEach((elt, idx) => {
      if (typeof elt === "function") {
        argMap["arg" + idx] = {
          id: window.__bridge__.Dispatcher.push(elt)
        };
      } else {
        argMap["arg" + idx] = elt;
      }
    });

    let text = JSON.stringify(argMap);
    BridgeKit.postMessage({
      identifier: id,
      args: text
    });
  }
})
