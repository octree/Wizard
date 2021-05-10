//
//  Injector.swift
//  SwiftWKBridge
//
//  Created by Octree on 2019/6/16.
//
//  Copyright (c) 2019 Octree <fouljz@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import JavaScriptCore

public class Injector: NSObject {
    private static let messageName = "bridge"
    private var pluginMap = [String: AnyPlugin]()
    private var bridgeKit = BridgeKit()
    private static let coreScript: String = {
        #if SWIFT_PACKAGE
        let bundle = Bundle.module
        #else
        let bundle = Bundle(for: Injector.self)
        #endif
        return String(fileName: "message", type: "js", bundle: bundle)!
    }()

    private weak var context: JSContext?

    init(context: JSContext) {
        self.context = context
        super.init()
        context.evaluateScript(Self.coreScript)
        bridgeKit.delegate = self
        context.setObject(bridgeKit, forKeyedSubscript: "BridgeKit" as NSString)
    }

    private func inject(script: String) {
        context?.evaluateScript(script)
    }
}

extension Injector: BridgeKitMessageHandler {
    func handleBridgeMessage(message: [String: String]) {
        guard let identifier = message["identifier"], let args = message["args"] else {
            return
        }
        guard let plugin = pluginMap[identifier] else {
            return
        }
        plugin.invoke(argString: args)
    }
}

// MARK: - Inject Methods
public extension Injector {

    /// 添加插件
    /// - Parameter path: 函数名称, eg: window.bridge.alert
    /// - Parameter plugin: 插件函数，webView 中调用 `path` 中指定的函数，就会调用这个函数
    func inject(path: String, plugin: @escaping () -> Void) {
        let f: (Args0) -> Void = { _ in
            plugin()
        }
        _inject(path: path,
                plugin: f,
                argsCount: 0)
    }

    /// 添加插件
    /// - Parameter path: 函数名称, eg: window.bridge.alert
    /// - Parameter plugin: 插件函数，webView 中调用 `path` 中指定的函数，就会调用这个函数
    /// - Parameter injectionTime: 注入时机
    func inject<P0>(path: String, plugin: @escaping (P0) -> Void) where P0: Decodable {
        let f: (Args1<P0>) -> Void = {
            plugin(self.processCallback($0.arg0))
        }
        _inject(path: path,
                plugin: f,
                argsCount: 1)
    }

    /// 添加插件
    /// - Parameter path: 函数名称, eg: window.bridge.alert
    /// - Parameter plugin: 插件函数，webView 中调用 `path` 中指定的函数，就会调用这个函数
    /// - Parameter injectionTime: 注入时机
    func inject<P0, P1>(path: String, plugin: @escaping (P0, P1) -> Void) where P0: Decodable, P1: Decodable {
        let f: (Args2) -> Void = {
            plugin(self.processCallback($0.arg0),
                   self.processCallback($0.arg1))
        }
        _inject(path: path,
                plugin: f,
                argsCount: 2)
    }

    /// 添加插件
    /// - Parameter path: 函数名称, eg: window.bridge.alert
    /// - Parameter plugin: 插件函数，webView 中调用 `path` 中指定的函数，就会调用这个函数
    /// - Parameter injectionTime: 注入时机
    func inject<P0, P1, P2>(path: String, plugin: @escaping (P0, P1, P2) -> Void) where P0: Decodable, P1: Decodable, P2: Decodable {
        let f: (Args3) -> Void = {
            plugin(self.processCallback($0.arg0),
                   self.processCallback($0.arg1),
                   self.processCallback($0.arg2))
        }
        _inject(path: path,
                plugin: f,
                argsCount: 3)
    }

    /// 添加插件
    /// - Parameter path: 函数名称, eg: window.bridge.alert
    /// - Parameter plugin: 插件函数，webView 中调用 `path` 中指定的函数，就会调用这个函数
    /// - Parameter injectionTime: 注入时机
    func inject<P0, P1, P2, P3>(path: String, plugin: @escaping (P0, P1, P2, P3) -> Void) where P0: Decodable, P1: Decodable, P2: Decodable, P3: Decodable {
        let f: (Args4) -> Void = {
            plugin(self.processCallback($0.arg0),
                   self.processCallback($0.arg1),
                   self.processCallback($0.arg2),
                   self.processCallback($0.arg3))
        }
        _inject(path: path,
                plugin: f,
                argsCount: 4)
    }

    /// 添加插件
    /// - Parameter path: 函数名称, eg: window.bridge.alert
    /// - Parameter plugin: 插件函数，webView 中调用 `path` 中指定的函数，就会调用这个函数
    /// - Parameter injectionTime: 注入时机
    func inject<P0, P1, P2, P3, P4>(path: String, plugin: @escaping (P0, P1, P2, P3, P4) -> Void) where P0: Decodable, P1: Decodable, P2: Decodable, P3: Decodable, P4: Decodable {
        let f: (Args5) -> Void = {
            plugin(self.processCallback($0.arg0),
                   self.processCallback($0.arg1),
                   self.processCallback($0.arg2),
                   self.processCallback($0.arg3),
                   self.processCallback($0.arg4))
        }
        _inject(path: path,
                plugin: f,
                argsCount: 5)
    }

    /// 添加插件
    /// - Parameter path: 函数名称, eg: window.bridge.alert
    /// - Parameter plugin: 插件函数，webView 中调用 `path` 中指定的函数，就会调用这个函数
    /// - Parameter injectionTime: 注入时机
    func inject<P0, P1, P2, P3, P4, P5>(path: String, plugin: @escaping (P0, P1, P2, P3, P4, P5) -> Void) where P0: Decodable, P1: Decodable, P2: Decodable, P3: Decodable, P4: Decodable, P5: Decodable {
        let f: (Args6) -> Void = {
            plugin(self.processCallback($0.arg0),
                   self.processCallback($0.arg1),
                   self.processCallback($0.arg2),
                   self.processCallback($0.arg3),
                   self.processCallback($0.arg4),
                   self.processCallback($0.arg5))
        }
        _inject(path: path,
                plugin: f,
                argsCount: 6)
    }

    /// 添加插件
    /// - Parameter path: 函数名称, eg: window.bridge.alert
    /// - Parameter plugin: 插件函数，webView 中调用 `path` 中指定的函数，就会调用这个函数
    /// - Parameter injectionTime: 注入时机
    func inject<P0, P1, P2, P3, P4, P5, P6>(path: String, plugin: @escaping (P0, P1, P2, P3, P4, P5, P6) -> Void) where P0: Decodable, P1: Decodable, P2: Decodable, P3: Decodable, P4: Decodable, P5: Decodable, P6: Decodable {
        let f: (Args7) -> Void = {
            plugin(self.processCallback($0.arg0),
                   self.processCallback($0.arg1),
                   self.processCallback($0.arg2),
                   self.processCallback($0.arg3),
                   self.processCallback($0.arg4),
                   self.processCallback($0.arg5),
                   self.processCallback($0.arg6))
        }
        _inject(path: path,
                plugin: f,
                argsCount: 7)
    }

    /// 添加插件
    /// - Parameter path: 函数名称, eg: window.bridge.alert
    /// - Parameter plugin: 插件函数，webView 中调用 `path` 中指定的函数，就会调用这个函数
    /// - Parameter injectionTime: 注入时机
    func inject<P0, P1, P2, P3, P4, P5, P6, P7>(path: String, plugin: @escaping (P0, P1, P2, P3, P4, P5, P6, P7) -> Void) where P0: Decodable, P1: Decodable, P2: Decodable, P3: Decodable, P4: Decodable, P5: Decodable, P6: Decodable, P7: Decodable {
        let f: (Args8) -> Void = {
            plugin(self.processCallback($0.arg0),
                   self.processCallback($0.arg1),
                   self.processCallback($0.arg2),
                   self.processCallback($0.arg3),
                   self.processCallback($0.arg4),
                   self.processCallback($0.arg5),
                   self.processCallback($0.arg6),
                   self.processCallback($0.arg7))
        }
        _inject(path: path,
                plugin: f,
                argsCount: 8)
    }

    private func _inject<Arg: ArgsType>(path: String, plugin: @escaping (Arg) -> Void, argsCount: Int) {
        pluginMap[path] = Plugin(context: context, path: path, f: plugin)
        inject(script: scriptForPlugin(withPath: path, argsCount: argsCount))
    }

    /// 删除插件
    /// - Parameter path: 函数名称, eg: window.bridge.alert
    func removePlugin(forPath path: String) {
        pluginMap[path] = nil
    }
}

// MARK: - JS Code Generator
extension Injector {
    private func objectDefineJavascriptCode(path: String) -> String {
        return """
        if(\(path)==null){ \(path) = {} }
        """
    }

    private func functionDefineCode(id: String, path: String, argsCount: Int) -> String {
        if argsCount == 0 {
            return """
            if(\(path)==null) { \(path) = function() { globalThis.__bridge__.invoke('\(id)')} }
            """
        }

        let args = (0 ..< argsCount).map { "a\($0)" }.joined(separator: ",")
        return """
        if(\(path)==null) { \(path) = function(\(args)) { globalThis.__bridge__.invoke('\(id)', \(args))} }
        """
    }

    private func scriptForPlugin(withPath path: String, argsCount: Int) -> String {
        let array = path.components(separatedBy: ".")
        let count = array.count - 1
        var pathTmp = array.first == "globalThis" ? "" : "globalThis"
        var code = ""

        var index = 0
        while index < count {
            pathTmp += ".\(array[index])"
            code += objectDefineJavascriptCode(path: pathTmp)
            index += 1
        }
        pathTmp += ".\(array[count])"
        return code + functionDefineCode(id: path, path: pathTmp, argsCount: argsCount)
    }
}

// MARK: - Invoke JS Callback Function
extension Injector {
    private func processCallback<P: Decodable>(_ arg: P) -> P {
        guard let callbck = arg as? Callback else {
            return arg
        }
        callbck.context = context
        return arg
    }
}
