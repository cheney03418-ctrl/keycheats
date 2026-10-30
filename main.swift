// KeyCheats — 菜单栏快捷键速查
// 原生 AppKit，无第三方依赖，无 Dock 图标。

import AppKit
import Carbon.HIToolbox

// MARK: - 数据

struct Shortcut {
    let title: String
    let keys: [String]
    var tip: String? = nil
    var kw: String = ""

    var id: String { keys.joined() + "|" + title }
}

struct Section {
    let name: String
    let items: [Shortcut]
}

private let englishKey: [String: String] = [
    "⌘": "Command", "⌥": "Option", "⌃": "Control", "⇧": "Shift",
    "⌫": "Delete", "⏎": "Return", "⎋": "Escape", "空格": "Space",
    "⇥": "Tab", "电源键": "Power", "fn": "Fn",
]

extension Shortcut {
    /// 给非中文系统/文档用的英文写法，如 Command+Shift+4
    var englishKeys: String {
        keys.map { englishKey[$0] ?? $0 }.joined(separator: "+")
    }
}

private let keyNames: [String: String] = [
    "⌘": "command cmd 命令",
    "⌥": "option alt 选项",
    "⌃": "control ctrl 控制",
    "⇧": "shift 上档",
    "⌫": "delete backspace 删除",
    "⏎": "return enter 回车",
    "⎋": "esc escape 退出",
    "空格": "space 空格",
    "⇥": "tab 制表",
    "↑": "up 上",
    "↓": "down 下",
    "←": "left 左",
    "→": "right 右",
]

func searchBlob(_ s: Shortcut) -> String {
    var parts = [s.title, s.kw, s.tip ?? ""]
    for k in s.keys {
        parts.append(k)
        parts.append(keyNames[k] ?? "")
    }
    return parts.joined(separator: " ").lowercased()
}

let data: [Section] = [
    Section(name: "常用编辑", items: [
        Shortcut(title: "复制", keys: ["⌘", "C"], kw: "copy fuzhi"),
        Shortcut(title: "粘贴", keys: ["⌘", "V"], kw: "paste zhan tie"),
        Shortcut(title: "剪切", keys: ["⌘", "X"], kw: "cut jianqie"),
        Shortcut(title: "撤销", keys: ["⌘", "Z"], kw: "undo chexiao"),
        Shortcut(title: "重做", keys: ["⇧", "⌘", "Z"], kw: "redo zhongzuo"),
        Shortcut(title: "全选", keys: ["⌘", "A"], kw: "select all quanxuan"),
        Shortcut(title: "查找", keys: ["⌘", "F"], kw: "find search chazhao"),
        Shortcut(title: "查找下一个", keys: ["⌘", "G"], kw: "find next"),
        Shortcut(title: "查找上一个", keys: ["⇧", "⌘", "G"], kw: "find previous"),
        Shortcut(title: "保存", keys: ["⌘", "S"], kw: "save baocun"),
        Shortcut(title: "打开", keys: ["⌘", "O"], kw: "open dakai"),
        Shortcut(title: "打印", keys: ["⌘", "P"], kw: "print dayin"),
        Shortcut(title: "新建标签页", keys: ["⌘", "T"], kw: "new tab xinjian biaoqian"),
        Shortcut(title: "关闭窗口", keys: ["⌘", "W"], kw: "close guanbi"),
        Shortcut(title: "关闭该 App 所有窗口", keys: ["⌥", "⌘", "W"], kw: "close all"),
        Shortcut(title: "最小化窗口", keys: ["⌘", "M"], kw: "minimize zuixiaohua"),
        Shortcut(title: "隐藏当前 App", keys: ["⌘", "H"], kw: "hide yincang"),
        Shortcut(title: "隐藏其他 App", keys: ["⌥", "⌘", "H"], kw: "hide others"),
        Shortcut(title: "彻底退出 App", keys: ["⌘", "Q"], kw: "quit tuichu"),
        Shortcut(title: "打开该 App 设置", keys: ["⌘", ","], kw: "preferences settings shezhi"),
        Shortcut(title: "粘贴并匹配样式", keys: ["⌥", "⇧", "⌘", "V"], tip: "去掉源格式，只留纯文本", kw: "paste match style chunwenben"),
        Shortcut(title: "打开帮助菜单", keys: ["⇧", "⌘", "?"], kw: "help bangzhu"),
    ]),

    Section(name: "截图与录屏", items: [
        Shortcut(title: "截取整个屏幕", keys: ["⇧", "⌘", "3"], kw: "截图 截屏 screenshot jietu quanping 全屏"),
        Shortcut(title: "截取选定区域", keys: ["⇧", "⌘", "4"], kw: "截图 截屏 screenshot area quyu 框选"),
        Shortcut(title: "截取指定窗口", keys: ["⇧", "⌘", "4", "空格"], tip: "按下后按空格，再点窗口；按住 ⌥ 可去掉阴影", kw: "截图 截屏 window screenshot chuangkou 单个窗口"),
        Shortcut(title: "截屏 / 录屏工具栏", keys: ["⇧", "⌘", "5"], tip: "可录屏、定时截图、改保存位置", kw: "截图 截屏 录屏 record luxiang toolbar"),
        Shortcut(title: "整屏截图到剪贴板", keys: ["⌃", "⇧", "⌘", "3"], kw: "截图 截屏 clipboard jianqieban"),
        Shortcut(title: "区域截图到剪贴板", keys: ["⌃", "⇧", "⌘", "4"], kw: "截图 截屏 clipboard jianqieban"),
    ]),

    Section(name: "窗口与切换", items: [
        Shortcut(title: "切换 App", keys: ["⌘", "⇥"], tip: "按住 ⌘ 不放，再按 Q 可直接退出选中的 App", kw: "switch app qiehuan"),
        Shortcut(title: "同一 App 内切换窗口", keys: ["⌘", "`"], kw: "switch window chuangkou"),
        Shortcut(title: "调度中心 Mission Control", keys: ["⌃", "↑"], tip: "看所有窗口和桌面", kw: "mission control diaodu"),
        Shortcut(title: "当前 App 的所有窗口", keys: ["⌃", "↓"], kw: "app exposé suoyou chuangkou"),
        Shortcut(title: "切换桌面", keys: ["⌃", "←", "→"], kw: "space desktop zhuomian"),
        Shortcut(title: "显示桌面", keys: ["F11"], tip: "笔记本需按 fn + F11", kw: "show desktop zhuomian"),
        Shortcut(title: "进入 / 退出全屏", keys: ["⌃", "⌘", "F"], kw: "fullscreen quanping"),
        Shortcut(title: "显示 / 隐藏 Dock", keys: ["⌥", "⌘", "D"], kw: "dock"),
    ]),

    Section(name: "文本与光标", items: [
        Shortcut(title: "跳到行首 / 行尾", keys: ["⌘", "←", "→"], kw: "line home end hang"),
        Shortcut(title: "跳到文档开头 / 结尾", keys: ["⌘", "↑", "↓"], kw: "document top bottom"),
        Shortcut(title: "按单词跳跃", keys: ["⌥", "←", "→"], kw: "word jump danci"),
        Shortcut(title: "删除前一个单词", keys: ["⌥", "⌫"], kw: "delete word shanchu"),
        Shortcut(title: "向后删除（Delete 键）", keys: ["fn", "⌫"], kw: "forward delete"),
        Shortcut(title: "选中到行首 / 行尾", keys: ["⇧", "⌘", "←", "→"], kw: "select line xuanzhong"),
        Shortcut(title: "按单词选中", keys: ["⌥", "⇧", "←", "→"], kw: "select word"),
        Shortcut(title: "选中到文档开头 / 结尾", keys: ["⇧", "⌘", "↑", "↓"], kw: "select all document"),
        Shortcut(title: "查词典 / 看释义", keys: ["⌃", "⌘", "D"], tip: "先选中单词", kw: "dictionary cidian"),
    ]),

    Section(name: "访达 Finder", items: [
        Shortcut(title: "新建 Finder 窗口", keys: ["⌘", "N"], kw: "new window xinjian"),
        Shortcut(title: "新建文件夹", keys: ["⇧", "⌘", "N"], kw: "new folder wenjianjia"),
        Shortcut(title: "前往文件夹（输路径）", keys: ["⇧", "⌘", "G"], kw: "go to folder lujing"),
        Shortcut(title: "移到废纸篓", keys: ["⌘", "⌫"], tip: "按住 ⌘ 再按 ⌫", kw: "trash delete shanchu"),
        Shortcut(title: "清空废纸篓", keys: ["⇧", "⌘", "⌫"], kw: "empty trash feizhilou"),
        Shortcut(title: "显示简介", keys: ["⌘", "I"], kw: "get info jianjie"),
        Shortcut(title: "复制副本", keys: ["⌘", "D"], kw: "duplicate fuben"),
        Shortcut(title: "快速查看", keys: ["空格"], tip: "选中文件后按空格", kw: "quick look kuaishu chakan"),
        Shortcut(title: "显示 / 隐藏隐藏文件", keys: ["⇧", "⌘", "."], kw: "hidden files yincang"),
        Shortcut(title: "回到上一级文件夹", keys: ["⌘", "↑"], kw: "enclosing folder shangji"),
        Shortcut(title: "后退 / 前进", keys: ["⌘", "[", "]"], kw: "back forward qianjin"),
        Shortcut(title: "主目录", keys: ["⇧", "⌘", "H"], kw: "home"),
        Shortcut(title: "桌面", keys: ["⇧", "⌘", "D"], kw: "desktop zhuomian"),
        Shortcut(title: "下载", keys: ["⌥", "⌘", "L"], kw: "downloads xiazai"),
        Shortcut(title: "应用程序", keys: ["⇧", "⌘", "A"], kw: "applications yingyong"),
        Shortcut(title: "实用工具", keys: ["⇧", "⌘", "U"], kw: "utilities shiyong"),
        Shortcut(title: "连接服务器", keys: ["⌘", "K"], kw: "connect server fuwuqi"),
        Shortcut(title: "图标 / 列表 / 分栏 / 画廊", keys: ["⌘", "1", "2", "3", "4"], kw: "view icons list columns gallery shitu"),
        Shortcut(title: "显示 / 隐藏路径栏", keys: ["⌥", "⌘", "P"], kw: "path bar lujing"),
        Shortcut(title: "显示 / 隐藏边栏", keys: ["⌥", "⌘", "S"], kw: "sidebar bianlan"),
    ]),

    Section(name: "浏览器", items: [
        Shortcut(title: "新标签页", keys: ["⌘", "T"], kw: "new tab biaoqian"),
        Shortcut(title: "关闭标签页", keys: ["⌘", "W"], kw: "close tab guanbi"),
        Shortcut(title: "重新打开刚关掉的标签", keys: ["⇧", "⌘", "T"], kw: "reopen tab huifu"),
        Shortcut(title: "跳到地址栏", keys: ["⌘", "L"], kw: "address bar dizhi"),
        Shortcut(title: "刷新页面", keys: ["⌘", "R"], kw: "reload refresh shuaxin"),
        Shortcut(title: "无痕 / 隐私窗口", keys: ["⇧", "⌘", "N"], tip: "Safari 与 Chrome 通用", kw: "incognito private wuhen"),
        Shortcut(title: "放大 / 缩小 / 原始大小", keys: ["⌘", "+", "-", "0"], kw: "zoom fangda suoxiao"),
        Shortcut(title: "页内查找", keys: ["⌘", "F"], kw: "find chazhao"),
        Shortcut(title: "回到页面顶部 / 底部", keys: ["⌘", "↑", "↓"], kw: "top bottom"),
    ]),

    Section(name: "系统与效率", items: [
        Shortcut(title: "Spotlight 聚焦搜索", keys: ["⌘", "空格"], tip: "搜文件、算数、换单位都能用", kw: "spotlight search jujiao"),
        Shortcut(title: "在 Finder 里搜索", keys: ["⌥", "⌘", "空格"], kw: "finder search"),
        Shortcut(title: "表情与符号面板", keys: ["⌃", "⌘", "空格"], kw: "emoji biaoqing fuhao"),
        Shortcut(title: "切换输入法", keys: ["⌃", "空格"], kw: "input source shurufa zhongyingwen"),
        Shortcut(title: "立即锁屏", keys: ["⌃", "⌘", "Q"], kw: "lock screen suoping"),
        Shortcut(title: "进入睡眠", keys: ["⌥", "⌘", "电源键"], kw: "sleep shuimian"),
        Shortcut(title: "关闭显示器", keys: ["⌃", "⇧", "电源键"], tip: "挂机下载时用这个，比睡眠更省电", kw: "display off guanping"),
        Shortcut(title: "关机 / 重启对话框", keys: ["⌃", "电源键"], kw: "shutdown restart guanji"),
        Shortcut(title: "注销当前用户", keys: ["⇧", "⌘", "Q"], kw: "log out zhuxiao"),
        Shortcut(title: "强制退出 App", keys: ["⌥", "⌘", "⎋"], tip: "程序卡死时用", kw: "force quit qiangzhi"),
        Shortcut(title: "快速备忘录", keys: ["fn", "Q"], kw: "quick note biji"),
        Shortcut(title: "反色显示", keys: ["⌃", "⌥", "⌘", "8"], tip: "需在 系统设置 → 键盘 → 快捷键 → 辅助功能 中开启", kw: "invert color fanse"),
    ]),
]

// MARK: - 收藏 / 最近使用

final class Store {
    private let d = UserDefaults.standard
    private let favKey = "kc.favorites"
    private let recentKey = "kc.recent"
    private let welcomeKey = "kc.didWelcome"

    var favorites: [String] { d.stringArray(forKey: favKey) ?? [] }
    var recent: [String] { d.stringArray(forKey: recentKey) ?? [] }

    func isFavorite(_ id: String) -> Bool { favorites.contains(id) }

    func toggleFavorite(_ id: String) {
        var f = favorites
        if let i = f.firstIndex(of: id) { f.remove(at: i) } else { f.append(id) }
        d.set(f, forKey: favKey)
    }

    func pushRecent(_ id: String) {
        var r = recent.filter { $0 != id }
        r.insert(id, at: 0)
        if r.count > 6 { r = Array(r.prefix(6)) }
        d.set(r, forKey: recentKey)
    }

    var needsWelcome: Bool { !d.bool(forKey: welcomeKey) }
    func markWelcomed() { d.set(true, forKey: welcomeKey) }
}

let byID: [String: Shortcut] = {
    var m: [String: Shortcut] = [:]
    for s in data { for i in s.items { m[i.id] = i } }
    return m
}()

let store = Store()

// MARK: - 视图

final class KeyCap: NSView {
    private let label = NSTextField(labelWithString: "")
    override var wantsUpdateLayer: Bool { true }

    init(_ text: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        wantsLayer = true
        label.stringValue = text
        label.font = .systemFont(ofSize: 11.5, weight: .medium)
        label.textColor = .labelColor
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            widthAnchor.constraint(equalToConstant: text.count > 1 ? CGFloat(14 + text.count * 7) : 22),
            heightAnchor.constraint(equalToConstant: 20),
        ])
    }

    required init?(coder: NSCoder) { fatalError() }

    override func updateLayer() {
        effectiveAppearance.performAsCurrentDrawingAppearance {
            layer?.cornerRadius = 4
            layer?.borderWidth = 1
            layer?.backgroundColor = NSColor.labelColor.withAlphaComponent(0.09).cgColor
            layer?.borderColor = NSColor.labelColor.withAlphaComponent(0.16).cgColor
        }
    }
}

final class RowView: NSTableCellView {
    private let titleLabel = NSTextField(labelWithString: "")
    private let tipLabel = NSTextField(labelWithString: "")
    private let badgeRow = NSStackView()
    private var highlighted = false

    override var wantsUpdateLayer: Bool { true }

    static func attributed(_ text: String, query: String) -> NSAttributedString {
        let base = NSMutableAttributedString(string: text, attributes: [
            .font: NSFont.systemFont(ofSize: 12.5),
            .foregroundColor: NSColor.labelColor,
        ])
        let lower = text.lowercased()
        for term in query.lowercased().split(separator: " ").map(String.init) where !term.isEmpty {
            var start = lower.startIndex
            while let r = lower.range(of: term, range: start..<lower.endIndex) {
                base.addAttributes([
                    .foregroundColor: NSColor.controlAccentColor,
                    .font: NSFont.systemFont(ofSize: 12.5, weight: .semibold),
                ], range: NSRange(r, in: text))
                start = r.upperBound
            }
        }
        return base
    }

    init(shortcut: Shortcut, query: String = "") {
        super.init(frame: .zero)
        wantsLayer = true
        layer?.cornerRadius = 6

        titleLabel.attributedStringValue = Self.attributed(shortcut.title, query: query)
        titleLabel.font = .systemFont(ofSize: 12.5, weight: .regular)
        titleLabel.textColor = .labelColor
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        tipLabel.stringValue = shortcut.tip ?? ""
        tipLabel.font = .systemFont(ofSize: 10.5)
        tipLabel.textColor = .secondaryLabelColor
        tipLabel.lineBreakMode = .byTruncatingTail
        tipLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        tipLabel.translatesAutoresizingMaskIntoConstraints = false
        tipLabel.isHidden = (shortcut.tip == nil)
        addSubview(tipLabel)

        badgeRow.orientation = .horizontal
        badgeRow.spacing = 3
        badgeRow.translatesAutoresizingMaskIntoConstraints = false
        badgeRow.setContentHuggingPriority(.required, for: .horizontal)
        for k in shortcut.keys { badgeRow.addArrangedSubview(KeyCap(k)) }
        addSubview(badgeRow)

        NSLayoutConstraint.activate([
            badgeRow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            badgeRow.centerYAnchor.constraint(equalTo: centerYAnchor),
            badgeRow.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 8),

            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: shortcut.tip == nil ? 8 : 4),

            tipLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            tipLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1),
            tipLabel.trailingAnchor.constraint(lessThanOrEqualTo: badgeRow.leadingAnchor, constant: -8),
        ])
    }

    required init?(coder: NSCoder) { fatalError() }

    func setHighlighted(_ on: Bool) {
        guard highlighted != on else { return }
        highlighted = on
        needsDisplay = true
    }

    override func updateLayer() {
        effectiveAppearance.performAsCurrentDrawingAppearance {
            layer?.backgroundColor = highlighted
                ? NSColor.controlAccentColor.withAlphaComponent(0.22).cgColor
                : NSColor.clear.cgColor
        }
    }

    private var tracking: NSTrackingArea?
    override func updateTrackingAreas() {
        super.updateTrackingAreas()
        if let t = tracking { removeTrackingArea(t) }
        let t = NSTrackingArea(rect: bounds,
                               options: [.mouseEnteredAndExited, .activeInActiveApp, .inVisibleRect],
                               owner: self, userInfo: nil)
        addTrackingArea(t)
        tracking = t
    }

    override func mouseEntered(with event: NSEvent) { setHighlighted(true) }
    override func mouseExited(with event: NSEvent) { setHighlighted(false) }
}

final class HeaderView: NSTableCellView {
    init(title: String) {
        super.init(frame: .zero)
        let l = NSTextField(labelWithString: title)
        l.font = .systemFont(ofSize: 10.5, weight: .semibold)
        l.textColor = .secondaryLabelColor
        l.translatesAutoresizingMaskIntoConstraints = false
        addSubview(l)
        NSLayoutConstraint.activate([
            l.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            l.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3),
        ])
    }
    required init?(coder: NSCoder) { fatalError() }
}

enum Row {
    case header(String)
    case item(Shortcut)
}

final class ShortcutTable: NSTableView {
    var menuProvider: ((Int) -> NSMenu?)?

    override func menu(for event: NSEvent) -> NSMenu? {
        let p = convert(event.locationInWindow, from: nil)
        let r = row(at: p)
        guard r >= 0 else { return nil }
        return menuProvider?(r)
    }
}

extension Notification.Name {
    static let keyCheatsClose = Notification.Name("KeyCheatsClose")
}

// MARK: - 主控制器

final class PanelController: NSViewController, NSTableViewDataSource, NSTableViewDelegate, NSSearchFieldDelegate {

    private let searchField = NSSearchField()
    private let tableView = ShortcutTable()
    private let scrollView = NSScrollView()
    private let footer = NSTextField(labelWithString: "")
    private let emptyLabel = NSTextField(labelWithString: "")
    private var rows: [Row] = []
    private var cursor: Int = -1
    private var currentQuery = ""
    private var feedbackTimer: Timer?

    override func loadView() {
        let root = NSVisualEffectView()
        root.material = .popover
        root.blendingMode = .behindWindow
        root.state = .active
        root.frame = NSRect(x: 0, y: 0, width: 400, height: 520)
        view = root

        searchField.placeholderString = "搜索：截图 / 复制 / shift 4 / command c"
        searchField.font = .systemFont(ofSize: 12.5)
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.delegate = self
        searchField.sendsWholeSearchString = false
        searchField.sendsSearchStringImmediately = true
        searchField.focusRingType = .none
        root.addSubview(searchField)

        let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("main"))
        column.resizingMask = .autoresizingMask
        tableView.addTableColumn(column)
        tableView.headerView = nil
        tableView.backgroundColor = .clear
        tableView.rowSizeStyle = .custom
        tableView.selectionHighlightStyle = .none
        tableView.intercellSpacing = NSSize(width: 0, height: 0)
        tableView.gridStyleMask = []
        tableView.dataSource = self
        tableView.delegate = self
        tableView.target = self
        tableView.action = #selector(rowClicked)
        tableView.menuProvider = { [weak self] row in self?.contextMenu(for: row) }
        if #available(macOS 11.0, *) { tableView.style = .plain }

        scrollView.documentView = tableView
        scrollView.hasVerticalScroller = true
        scrollView.drawsBackground = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.scrollerStyle = .overlay
        root.addSubview(scrollView)

        footer.stringValue = "点一下复制 · 右键收藏 · ⌥⌘K 唤起"
        footer.font = .systemFont(ofSize: 10)
        footer.textColor = .tertiaryLabelColor
        footer.alignment = .center
        footer.translatesAutoresizingMaskIntoConstraints = false
        root.addSubview(footer)

        emptyLabel.stringValue = "没找到，换个说法试试（如「截图」「废纸篓」「shift 4」）"
        emptyLabel.font = .systemFont(ofSize: 11.5)
        emptyLabel.textColor = .tertiaryLabelColor
        emptyLabel.alignment = .center
        emptyLabel.isHidden = true
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        root.addSubview(emptyLabel)

        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: root.topAnchor, constant: 10),
            searchField.leadingAnchor.constraint(equalTo: root.leadingAnchor, constant: 10),
            searchField.trailingAnchor.constraint(equalTo: root.trailingAnchor, constant: -10),

            scrollView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 6),
            scrollView.leadingAnchor.constraint(equalTo: root.leadingAnchor, constant: 4),
            scrollView.trailingAnchor.constraint(equalTo: root.trailingAnchor, constant: -4),
            scrollView.bottomAnchor.constraint(equalTo: footer.topAnchor, constant: -2),

            footer.leadingAnchor.constraint(equalTo: root.leadingAnchor, constant: 10),
            footer.trailingAnchor.constraint(equalTo: root.trailingAnchor, constant: -10),
            footer.bottomAnchor.constraint(equalTo: root.bottomAnchor, constant: -6),
            footer.heightAnchor.constraint(equalToConstant: 14),

            emptyLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: -40),
            emptyLabel.leadingAnchor.constraint(greaterThanOrEqualTo: root.leadingAnchor, constant: 20),
        ])

        rebuild(query: "")
    }

    func focusSearch() {
        view.window?.makeFirstResponder(searchField)
        searchField.currentEditor()?.selectAll(nil)
    }

    func applyQuery(_ s: String) {
        searchField.stringValue = s
        rebuild(query: s)
    }

    // MARK: 过滤

    private func rebuild(query: String) {
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        currentQuery = q
        var out: [Row] = []
        if q.isEmpty {
            // 置顶：收藏 → 最近使用
            let favs = store.favorites.compactMap { byID[$0] }
            if !favs.isEmpty {
                out.append(.header("★ 我的收藏"))
                for i in favs { out.append(.item(i)) }
            }
            let recents = store.recent.compactMap { byID[$0] }
            if !recents.isEmpty {
                out.append(.header("↺ 最近用过"))
                for i in recents { out.append(.item(i)) }
            }
            for s in data {
                out.append(.header(s.name))
                for i in s.items { out.append(.item(i)) }
            }
        } else {
            let terms = q.split(separator: " ").map(String.init)
            for s in data {
                let hits = s.items.filter { item in
                    let b = searchBlob(item)
                    return terms.allSatisfy { b.contains($0) }
                }
                if !hits.isEmpty {
                    out.append(.header(s.name))
                    for i in hits { out.append(.item(i)) }
                }
            }
        }
        rows = out
        cursor = q.isEmpty ? -1 : firstItemIndex()
        emptyLabel.isHidden = out.contains { if case .item = $0 { return true } else { return false } }
        tableView.reloadData()
        if cursor >= 0 {
            tableView.scrollRowToVisible(cursor)
            cellView(cursor)?.setHighlighted(true)
        } else {
            tableView.scrollRowToVisible(0)
        }
    }

    private func cellView(_ row: Int) -> RowView? {
        guard row >= 0, row < rows.count else { return nil }
        return tableView.view(atColumn: 0, row: row, makeIfNecessary: false) as? RowView
    }

    private func firstItemIndex() -> Int {
        for (i, r) in rows.enumerated() { if case .item = r { return i } }
        return -1
    }

    // MARK: Table

    func numberOfRows(in tableView: NSTableView) -> Int { rows.count }

    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        switch rows[row] {
        case .header: return 26
        case .item(let s): return s.tip == nil ? 30 : 40
        }
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        switch rows[row] {
        case .header(let name): return HeaderView(title: name)
        case .item(let s): return RowView(shortcut: s, query: currentQuery)
        }
    }

    // MARK: 交互

    @objc private func rowClicked() {
        let r = tableView.clickedRow
        guard r >= 0, r < rows.count, case .item(let s) = rows[r] else { return }
        copy(s)
    }

    private func moveCursor(_ delta: Int) {
        guard !rows.isEmpty else { return }
        var idx = cursor
        repeat {
            idx += delta
            if idx < 0 { idx = rows.count - 1 }
            if idx >= rows.count { idx = 0 }
        } while idx != cursor && isHeader(idx)
        guard !isHeader(idx) else { return }
        if cursor >= 0, cursor < rows.count {
            cellView(cursor)?.setHighlighted(false)
        }
        cursor = idx
        tableView.scrollRowToVisible(idx)
        cellView(idx)?.setHighlighted(true)
    }

    private func isHeader(_ i: Int) -> Bool {
        guard i >= 0, i < rows.count else { return true }
        if case .header = rows[i] { return true }
        return false
    }

    private func copyCurrent() {
        guard cursor >= 0, cursor < rows.count, case .item(let s) = rows[cursor] else { return }
        copy(s)
    }

    private func copy(_ s: Shortcut) {
        let text = s.keys.map { $0 == "空格" ? "Space" : ($0 == "电源键" ? "Power" : $0) }.joined()
        let pb = NSPasteboard.general
        pb.clearContents()
        pb.setString(text, forType: .string)
        footer.stringValue = "已复制  \(text)   —  \(s.title)"
        footer.textColor = .controlAccentColor
        store.pushRecent(s.id)
        feedbackTimer?.invalidate()
        feedbackTimer = Timer.scheduledTimer(withTimeInterval: 1.4, repeats: false) { [weak self] _ in
            self?.resetFooter()
        }
    }

    // MARK: 右键菜单

    private func contextMenu(for row: Int) -> NSMenu? {
        guard row >= 0, row < rows.count, case .item(let s) = rows[row] else { return nil }
        let menu = NSMenu()
        let fav = NSMenuItem(title: store.isFavorite(s.id) ? "取消收藏" : "收藏到顶部",
                             action: #selector(menuToggleFavorite(_:)), keyEquivalent: "")
        fav.target = self
        fav.representedObject = row
        menu.addItem(fav)

        let en = NSMenuItem(title: "复制英文写法  \(s.englishKeys)",
                            action: #selector(menuCopyEnglish(_:)), keyEquivalent: "")
        en.target = self
        en.representedObject = row
        menu.addItem(en)
        return menu
    }

    @objc private func menuToggleFavorite(_ sender: NSMenuItem) {
        guard let r = sender.representedObject as? Int, r < rows.count,
              case .item(let s) = rows[r] else { return }
        store.toggleFavorite(s.id)
        rebuild(query: searchField.stringValue)
    }

    @objc private func menuCopyEnglish(_ sender: NSMenuItem) {
        guard let r = sender.representedObject as? Int, r < rows.count,
              case .item(let s) = rows[r] else { return }
        let pb = NSPasteboard.general
        pb.clearContents()
        pb.setString(s.englishKeys, forType: .string)
        footer.stringValue = "已复制  \(s.englishKeys)"
        footer.textColor = .controlAccentColor
        feedbackTimer?.invalidate()
        feedbackTimer = Timer.scheduledTimer(withTimeInterval: 1.4, repeats: false) { [weak self] _ in
            self?.resetFooter()
        }
    }

    private func resetFooter() {
        footer.stringValue = "点一下复制 · 右键收藏 · ⌥⌘K 唤起"
        footer.textColor = .tertiaryLabelColor
    }

    // MARK: 搜索框

    func controlTextDidChange(_ obj: Notification) {
        rebuild(query: searchField.stringValue)
    }

    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        switch commandSelector {
        case #selector(NSResponder.moveDown(_:)):
            moveCursor(1); return true
        case #selector(NSResponder.moveUp(_:)):
            moveCursor(-1); return true
        case #selector(NSResponder.insertNewline(_:)):
            copyCurrent(); return true
        case #selector(NSResponder.cancelOperation(_:)):
            NotificationCenter.default.post(name: .keyCheatsClose, object: nil)
            return true
        default:
            return false
        }
    }
}

// MARK: - App

final class AppDelegate: NSObject, NSApplicationDelegate, NSPopoverDelegate {
    private var statusItem: NSStatusItem!
    private let popover = NSPopover()
    private let panel = PanelController()
    private var hotKeyRef: EventHotKeyRef?
    private var lastCloseAt = Date.distantPast
    private let launchAgentLabel = "com.aaron.keycheats"

    var isPopoverShown: Bool { popover.isShown }

    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem.button {
            let img = NSImage(systemSymbolName: "command", accessibilityDescription: "快捷键速查")
            img?.isTemplate = true
            button.image = img
            button.imagePosition = .imageOnly
            button.toolTip = "快捷键速查（⌥⌘K）"
            button.target = self
            button.action = #selector(statusClicked(_:))
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }

        popover.contentViewController = panel
        popover.behavior = .transient
        popover.animates = false
        popover.delegate = self

        registerHotKey()
        installLaunchAgentIfNeeded()

        // 首次启动自动弹一次，免得找不到菜单栏图标
        if store.needsWelcome {
            store.markWelcomed()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [weak self] in
                self?.toggle()
            }
        }

        NotificationCenter.default.addObserver(forName: .keyCheatsClose, object: nil, queue: .main) { [weak self] _ in
            self?.popover.performClose(nil)
        }
    }

    @objc private func statusClicked(_ sender: NSStatusBarButton) {
        if NSApp.currentEvent?.type == .rightMouseUp {
            showMenu()
        } else {
            toggle()
        }
    }

    func toggle() {
        if popover.isShown {
            popover.performClose(nil)
            return
        }
        // transient 弹窗在点图标时会先自动关闭，随后的点击又会立刻重开；用时间窗挡住这一下
        if Date().timeIntervalSince(lastCloseAt) < 0.25 { return }
        guard let button = statusItem.button else { return }
        NSApp.activate(ignoringOtherApps: true)
        popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
        popover.contentViewController?.view.window?.makeKey()
        panel.focusSearch()
    }

    func popoverDidClose(_ notification: Notification) {
        lastCloseAt = Date()
        panel.applyQuery("")
    }

    private func showMenu() {
        let menu = NSMenu()
        menu.addItem(withTitle: "打开快捷键速查", action: #selector(openFromMenu), keyEquivalent: "")
        let login = NSMenuItem(title: "开机自动启动", action: #selector(toggleLogin), keyEquivalent: "")
        login.state = FileManager.default.fileExists(atPath: launchAgentPath) ? .on : .off
        menu.addItem(login)
        menu.addItem(.separator())
        menu.addItem(withTitle: "退出", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
        statusItem.menu = menu
        statusItem.button?.performClick(nil)
        statusItem.menu = nil
    }

    @objc private func openFromMenu() { toggle() }

    // MARK: 全局快捷键 ⌥⌘K

    private func registerHotKey() {
        var eventType = EventTypeSpec(eventClass: OSType(kEventClassKeyboard), eventKind: UInt32(kEventHotKeyPressed))
        InstallEventHandler(GetApplicationEventTarget(), { _, _, _ in
            DispatchQueue.main.async {
                (NSApp.delegate as? AppDelegate)?.toggle()
            }
            return noErr
        }, 1, &eventType, nil, nil)

        let hotKeyID = EventHotKeyID(signature: OSType(0x4B43_4853), id: 1) // 'KCHS'
        RegisterEventHotKey(UInt32(cmdKey | optionKey), UInt32(kVK_ANSI_K),
                            hotKeyID, GetApplicationEventTarget(), 0, &hotKeyRef)
    }

    // MARK: 开机自启

    private var launchAgentPath: String {
        NSHomeDirectory() + "/Library/LaunchAgents/\(launchAgentLabel).plist"
    }

    private func installLaunchAgentIfNeeded() {
        guard !FileManager.default.fileExists(atPath: launchAgentPath) else { return }
        writeLaunchAgent()
    }

    private func writeLaunchAgent() {
        let exe = Bundle.main.executablePath ?? ""
        let plist = """
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
            <key>Label</key><string>\(launchAgentLabel)</string>
            <key>ProgramArguments</key>
            <array><string>\(exe)</string></array>
            <key>RunAtLoad</key><true/>
            <key>KeepAlive</key><false/>
            <key>ProcessType</key><string>Interactive</string>
        </dict>
        </plist>
        """
        try? plist.write(toFile: launchAgentPath, atomically: true, encoding: .utf8)
        // 只写文件，不 bootstrap：App 此刻已在运行，立刻加载会多开一个实例。
        // LaunchAgent 会在下次登录时生效。
    }

    @objc private func toggleLogin() {
        let fm = FileManager.default
        if fm.fileExists(atPath: launchAgentPath) {
            let uid = String(getuid())
            shell("/bin/launchctl", ["bootout", "gui/\(uid)/\(launchAgentLabel)"])
            try? fm.removeItem(atPath: launchAgentPath)
        } else {
            writeLaunchAgent()
        }
    }

    private func shell(_ path: String, _ args: [String]) {
        let p = Process()
        p.executableURL = URL(fileURLWithPath: path)
        p.arguments = args
        p.standardOutput = Pipe()
        p.standardError = Pipe()
        try? p.run()
        p.waitUntilExit()
    }
}

// MARK: - 启动

// 离线渲染面板截图，用于自检布局：KeyCheats --snapshot /tmp/panel.png
if let i = CommandLine.arguments.firstIndex(of: "--snapshot"), i + 1 < CommandLine.arguments.count {
    let outPath = CommandLine.arguments[i + 1]
    let pc = PanelController()
    let v = pc.view
    v.frame = NSRect(x: 0, y: 0, width: 400, height: 520)
    if let qi = CommandLine.arguments.firstIndex(of: "--q"), qi + 1 < CommandLine.arguments.count {
        pc.applyQuery(CommandLine.arguments[qi + 1])
    }
    let win = NSWindow(contentRect: v.bounds, styleMask: [.borderless], backing: .buffered, defer: false)
    win.appearance = NSAppearance(named: .darkAqua)
    win.contentView = v
    v.layoutSubtreeIfNeeded()
    let rep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: 800, pixelsHigh: 1040,
                               bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false,
                               colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)!
    rep.size = NSSize(width: 400, height: 520)
    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: rep)
    NSColor(white: 0.02, alpha: 1).setFill()
    v.bounds.fill()
    v.cacheDisplay(in: v.bounds, to: rep)
    NSGraphicsContext.restoreGraphicsState()

    // 离屏渲染时 NSVisualEffectView 的 material 会退化成不透明中灰（约 0.23）。
    // 做一次色阶压缩：黑场 0.20、白场 1.0，把灰底压到近黑，文字仍是纯白。
    if let data = rep.bitmapData {
        let spp = rep.bitsPerPixel / 8
        for y in 0..<rep.pixelsHigh {
            let row = data + y * rep.bytesPerRow
            for x in 0..<rep.pixelsWide {
                let px = row + x * spp
                for c in 0..<3 {
                    let v = Double(px[c]) / 255.0
                    px[c] = UInt8(max(0, min(1, (v - 0.20) / 0.80)) * 255)
                }
            }
        }
    }

    try? rep.representation(using: .png, properties: [:])?.write(to: URL(fileURLWithPath: outPath))
    exit(0)
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.setActivationPolicy(.accessory)

if CommandLine.arguments.contains("--show-test") {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
        delegate.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            print("popoverShown=\(delegate.isPopoverShown)")
            fflush(stdout)
            NSApp.terminate(nil)
        }
    }
}

app.run()
