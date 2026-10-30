// 生成 AppIcon.icns 用：绘制 1024x1024 图标 PNG
import AppKit

let S: CGFloat = 1024
let img = NSImage(size: NSSize(width: S, height: S))
img.lockFocus()
let ctx = NSGraphicsContext.current!.cgContext

// 画布透明底
ctx.clear(CGRect(x: 0, y: 0, width: S, height: S))

// macOS 圆角方形：内容区 824，圆角约 185
let inset: CGFloat = 100
let rect = CGRect(x: inset, y: inset, width: S - inset * 2, height: S - inset * 2)
let path = NSBezierPath(roundedRect: rect, xRadius: 185, yRadius: 185)

path.addClip()
let grad = NSGradient(colors: [
    NSColor(srgbRed: 0.36, green: 0.36, blue: 0.98, alpha: 1),
    NSColor(srgbRed: 0.62, green: 0.28, blue: 0.92, alpha: 1),
])!
grad.draw(in: rect, angle: -70)

// 内侧高光
let top = NSBezierPath(roundedRect: rect.insetBy(dx: 6, dy: 6), xRadius: 179, yRadius: 179)
NSColor.white.withAlphaComponent(0.12).setStroke()
top.lineWidth = 8
top.stroke()

// ⌘ 字形
let glyph = "⌘" as NSString
let font = NSFont.systemFont(ofSize: 520, weight: .medium)
let attrs: [NSAttributedString.Key: Any] = [
    .font: font,
    .foregroundColor: NSColor.white.withAlphaComponent(0.97),
]
let size = glyph.size(withAttributes: attrs)
glyph.draw(at: NSPoint(x: (S - size.width) / 2, y: (S - size.height) / 2 + 10), withAttributes: attrs)

img.unlockFocus()

let tiff = img.tiffRepresentation!
let rep = NSBitmapImageRep(data: tiff)!
let png = rep.representation(using: .png, properties: [:])!
try! png.write(to: URL(fileURLWithPath: CommandLine.arguments[1]))
print("ok")
