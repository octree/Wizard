//
//  Message.swift
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

import Foundation
import JavaScriptCore

private extension Encodable {
    func toJSONData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}

public class Callback: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
    }

    var id: String
    weak var context: JSContext?

    public func invoke(_ args: Encodable...) {
        _invoke(args: args)
    }

    public func callAsFunction(_ args: Encodable...) {
        _invoke(args: args)
    }

    private func _invoke(args: [Encodable]) {
        do {
            let params = try args.map { try String(data: $0.toJSONData(), encoding: .utf8)! }.joined(separator: ", ")
            var source: String
            if params.count > 0 {
                source = "globalThis.__bridge__.Dispatcher.invoke('\(id)', \(params))"
            } else {
                source = "globalThis.__bridge__.Dispatcher.invoke('\(id)')"
            }
            context?.evaluateScript(source)
        } catch {
            fatalError()
        }
    }

    deinit {
        let source = "globalThis.__bridge__.Dispatcher.remove('\(id)')"
        context?.evaluateScript(source)
    }
}

protocol ArgsType: Decodable {}

struct Args0: Decodable, ArgsType {}

struct Args1<P0: Decodable>: Decodable, ArgsType {
    var arg0: P0
}

struct Args2<P0: Decodable, P1: Decodable>: Decodable, ArgsType {
    var arg0: P0
    var arg1: P1
}

struct Args3<P0: Decodable, P1: Decodable, P2: Decodable>: Decodable, ArgsType {
    var arg0: P0
    var arg1: P1
    var arg2: P2
}

struct Args4<P0: Decodable, P1: Decodable, P2: Decodable, P3: Decodable>: Decodable, ArgsType {
    var arg0: P0
    var arg1: P1
    var arg2: P2
    var arg3: P3
}

struct Args5<P0: Decodable, P1: Decodable, P2: Decodable, P3: Decodable, P4: Decodable>: Decodable, ArgsType {
    var arg0: P0
    var arg1: P1
    var arg2: P2
    var arg3: P3
    var arg4: P4
}

struct Args6<P0: Decodable, P1: Decodable, P2: Decodable, P3: Decodable, P4: Decodable, P5: Decodable>: Decodable, ArgsType {
    var arg0: P0
    var arg1: P1
    var arg2: P2
    var arg3: P3
    var arg4: P4
    var arg5: P5
}

struct Args7<P0: Decodable, P1: Decodable, P2: Decodable, P3: Decodable, P4: Decodable, P5: Decodable, P6: Decodable>: Decodable, ArgsType {
    var arg0: P0
    var arg1: P1
    var arg2: P2
    var arg3: P3
    var arg4: P4
    var arg5: P5
    var arg6: P6
}

struct Args8<P0: Decodable, P1: Decodable, P2: Decodable, P3: Decodable, P4: Decodable, P5: Decodable, P6: Decodable, P7: Decodable>: Decodable, ArgsType {
    var arg0: P0
    var arg1: P1
    var arg2: P2
    var arg3: P3
    var arg4: P4
    var arg5: P5
    var arg6: P6
    var arg7: P7
}
