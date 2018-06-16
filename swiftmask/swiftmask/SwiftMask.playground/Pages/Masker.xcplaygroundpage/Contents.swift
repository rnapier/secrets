import Foundation

func applyMask(to raw: Data, with mask: Data) -> Data {
    precondition(raw.count == mask.count)
    return Data(zip(raw, mask).map(^))
}

func demaskString(from masked: Data, with mask: Data) -> String {
    return String(data: applyMask(to: masked, with: mask), encoding: .utf8)!
}

extension Collection {
    func groups(withMaximumLength maxLength: Int) -> [SubSequence] {
        var result: [SubSequence] = []
        var rangeStart = startIndex
        while rangeStart != endIndex {
            let rangeEnd = self.index(rangeStart, offsetBy: maxLength, limitedBy: endIndex) ?? endIndex
            result.append(self[rangeStart..<rangeEnd])
            rangeStart = rangeEnd
        }
        return result
    }
}

func generateCode(for data: Data, named name: String) -> String {
    let bytes = data.groups(withMaximumLength: 12)
        .map { $0.map { String(format: "0x%x", $0) }.joined(separator: ", ") }
        .joined(separator: ",\n    ")

    return """
let \(name) = Data([
    \(bytes)
    ])
"""
}

let secret = "TYYLWKMUAPZHLYXJMPUW"

let secretData = Data(secret.utf8)
let maskBytes = (0..<secretData.count).map { _ in UInt8.random(in: UInt8.min...UInt8.max) }
let mask = Data(maskBytes)

let maskedSecret = applyMask(to: secretData, with: mask)

print("""
func applyMask(to raw: Data, with mask: Data) -> Data {
    precondition(raw.count == mask.count)
    return Data(zip(raw, mask).map(^))
}

func demaskString(from masked: Data, with mask: Data) -> String {
    return String(data: applyMask(to: masked, with: mask), encoding: .utf8)!
}

\(generateCode(for: maskedSecret, named: "masked"))

\(generateCode(for: mask, named: "mask"))

let secret = demaskString(from: masked, with: mask)
""")
