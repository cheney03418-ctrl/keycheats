// 生成小红书首图 1242x1656（3:4）
import AppKit

let W: CGFloat = 1242, H: CGFloat = 1656
let img = NSImage(size: NSSize(width: W, height: H))
img.lockFocus()
let ctx = NSGraphicsContext.current!.cgContext

func font(_ size: CGFloat, _ bold: Bool) -> NSFont {
    if let base = NSFont(name: "PingFang SC", size: size) {
        return bold ? NSFontManager.shared.convert(base, toHaveTrait: .boldFontMask) : base
    }
    return NSFont.systemFont(ofSize: size, weight: bold ? .bold : .regular)
}

/// 按宽度自动缩字号，保证一行放得下
func fitFont(_ text: String, maxWidth: CGFloat, start: CGFloat, bold: Bool) -> NSFont {
    var size = start
    while size > 20 {
        let f = font(size, bold)
        if (text as NSString).size(withAttributes: [.font: f]).width <= maxWidth { return f }
        size -= 2
    }
    return font(20, bold)
}

// 背景
NSGradient(colors: [
    NSColor(srgbRed: 0.07, green: 0.06, blue: 0.12, alpha: 1),
    NSColor(srgbRed: 0.16, green: 0.09, blue: 0.26, alpha: 1),
])!.draw(in: CGRect(x: 0, y: 0, width: W, height: H), angle: -78)

NSGradient(colors: [
    NSColor(srgbRed: 0.55, green: 0.35, blue: 1.0, alpha: 0.50),
    NSColor(srgbRed: 0.55, green: 0.35, blue: 1.0, alpha: 0.0),
])!.draw(in: NSBezierPath(ovalIn: CGRect(x: -260, y: H - 640, width: 1760, height: 980)),
         relativeCenterPosition: .zero)

/// 以「距顶部多少」定位，内部换算成 AppKit 的底部原点
func drawText(_ text: String, font f: NSFont, color: NSColor, top: CGFloat, align: String = "center") {
    let attrs: [NSAttributedString.Key: Any] = [.font: f, .foregroundColor: color]
    let size = (text as NSString).size(withAttributes: attrs)
    let x: CGFloat = align == "center" ? (W - size.width) / 2 : 90
    (text as NSString).draw(at: NSPoint(x: x, y: H - top - size.height), withAttributes: attrs)
}

// 顶部标签
let tag = "我用 Swift 写了一个小工具"
let tagFont = font(34, false)
let tagSize = (tag as NSString).size(withAttributes: [.font: tagFont])
let tagRect = CGRect(x: (W - tagSize.width - 64) / 2, y: H - 84 - 64, width: tagSize.width + 64, height: 64)
let tagPath = NSBezierPath(roundedRect: tagRect, xRadius: 32, yRadius: 32)
NSColor.white.withAlphaComponent(0.10).setFill()
tagPath.fill()
NSColor.white.withAlphaComponent(0.22).setStroke()
tagPath.lineWidth = 2
tagPath.stroke()
(tag as NSString).draw(at: NSPoint(x: tagRect.minX + 32, y: tagRect.minY + 13),
                       withAttributes: [.font: tagFont, .foregroundColor: NSColor.white.withAlphaComponent(0.85)])

// 主标题（两行，自动缩字号）
let t1 = "记不住 Mac 快捷键"
let t2 = "我给自己写了个外挂"
let f1 = fitFont(t1, maxWidth: W - 140, start: 96, bold: true)
let f2 = fitFont(t2, maxWidth: W - 140, start: 96, bold: true)
drawText(t1, font: f1, color: .white, top: 196)
let h1 = (t1 as NSString).size(withAttributes: [.font: f1]).height
drawText(t2, font: f2, color: NSColor(srgbRed: 0.74, green: 0.64, blue: 1.0, alpha: 1), top: 196 + h1 + 8)

// 副标题
let sub = "不到 500 KB · 常驻菜单栏 · ⌥⌘K 唤起 · 点一下就复制"
let subFont = fitFont(sub, maxWidth: W - 160, start: 36, bold: false)
drawText(sub, font: subFont, color: NSColor.white.withAlphaComponent(0.55), top: 470)

// 面板截图
if let panel = NSImage(contentsOfFile: CommandLine.arguments[1]) {
    let pw: CGFloat = 780
    let ph = pw * panel.size.height / panel.size.width
    let top: CGFloat = 580
    let rect = CGRect(x: (W - pw) / 2, y: H - top - ph, width: pw, height: ph)

    ctx.saveGState()
    ctx.setShadow(offset: CGSize(width: 0, height: -16), blur: 56,
                  color: NSColor.black.withAlphaComponent(0.6).cgColor)
    NSColor.black.setFill()
    NSBezierPath(roundedRect: rect, xRadius: 24, yRadius: 24).fill()
    ctx.restoreGState()

    ctx.saveGState()
    NSBezierPath(roundedRect: rect, xRadius: 24, yRadius: 24).addClip()
    panel.draw(in: rect)
    ctx.restoreGState()

    NSColor.white.withAlphaComponent(0.14).setStroke()
    let border = NSBezierPath(roundedRect: rect, xRadius: 24, yRadius: 24)
    border.lineWidth = 2
    border.stroke()
}

img.unlockFocus()

let rep = NSBitmapImageRep(data: img.tiffRepresentation!)!
try! rep.representation(using: .png, properties: [:])!
    .write(to: URL(fileURLWithPath: CommandLine.arguments[2]))
print("ok")
