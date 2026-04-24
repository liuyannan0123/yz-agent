import AppKit
import Foundation
import Vision

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data((message + "\n").utf8))
    exit(1)
}

guard CommandLine.arguments.count >= 2 else {
    fail("missing image path")
}

let path = CommandLine.arguments[1]
let url = URL(fileURLWithPath: path)

guard let image = NSImage(contentsOf: url) else {
    fail("failed to load image")
}

var imageRect = CGRect(origin: .zero, size: image.size)
guard let cgImage = image.cgImage(forProposedRect: &imageRect, context: nil, hints: nil) else {
    fail("failed to decode image")
}

let request = VNRecognizeTextRequest()
request.recognitionLevel = .accurate
request.usesLanguageCorrection = true
request.recognitionLanguages = ["zh-Hans", "en-US"]

let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])

do {
    try handler.perform([request])
} catch {
    fail("vision OCR failed: \(error.localizedDescription)")
}

let observations = request.results as? [VNRecognizedTextObservation] ?? []
let lines = observations.compactMap { observation -> String? in
    observation.topCandidates(1).first?.string
}

print(lines.joined(separator: "\n"))
