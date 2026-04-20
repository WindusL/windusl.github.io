import Foundation

/// 双语字幕功能测试用例
/// 这些测试用例可以用于验证双语字幕解析和切换功能

// MARK: - 测试用例数据

/// 单语字幕示例（中文）
let singleLanguageSRT = """
1
00:00:01,000 --> 00:00:03,000
这是单语字幕内容

2
00:00:04,000 --> 00:00:06,000
第二句单语字幕
"""

/// 双语字幕示例（上下排列，中英文）
let bilingualVerticalSRT = """
1
00:00:01,000 --> 00:00:03,000
这是中文内容
This is English content

2
00:00:04,000 --> 00:00:06,000
第二句中文
The second English line
"""

/// 双语字幕示例（使用分隔符）
let bilingualSeparatorSRT = """
1
00:00:01,000 --> 00:00:03,000
这是中文内容 ||| This is English content

2
00:00:04,000 --> 00:00:06,000
第二句中文 ||| The second English line
"""

// MARK: - 预期行为

/*
 测试用例 1：单语字幕
 输入：singleLanguageSRT
 预期结果：
 - availableLanguages: [.primary, .none]
 - selectedLanguage 默认为 .primary
 - hasMultipleLanguages: false
 - 按钮仅在"显示"和"隐藏"之间切换

 测试用例 2：中英双语（上下排列）
 输入：bilingualVerticalSRT
 预期结果：
 - availableLanguages: [.primary, .secondary, .both, .none]
 - selectedLanguage 默认为 .primary
 - hasMultipleLanguages: true
 - 菜单显示"中文"、"English"、"双语"、"隐藏"四个选项
 - 选择 .primary 时只显示中文
 - 选择 .secondary 时只显示英文
 - 选择 .both 时同时显示中英文
 - 选择 .none 时隐藏字幕

 测试用例 3：中英双语（分隔符）
 输入：bilingualSeparatorSRT
 预期结果：
 - availableLanguages: [.primary, .secondary, .both, .none]
 - 正确识别分隔符 "|||"
 - 分离中英文内容
 - 其他行为与测试用例 2 相同
*/

// MARK: - 字符检测示例

/*
 SubtitleTextParser 支持以下检测方式：

 1. 分隔符检测：
    - "|||" (三个竖线)
    - "||" (两个竖线)
    - " //" (空格+双斜杠+空格)
    - "//" (双斜杠)
    - " | " (空格+竖线+空格)
    - "|" (竖线)

 2. 多行检测：
    - 检测上下排列的双语文本
    - 第一行作为主要语言
    - 第二行作为次要语言

 3. 字符集检测：
    - isChineseCharacter: 检测 CJK 统一汉字范围内的字符
    - isLatinCharacter: 检测拉丁字母（包括英文字母、数字）
    - 通过字符比例判断是否为不同语言

 示例：
 - "你好" -> 主要包含中文字符
 - "Hello" -> 主要包含拉丁字符
 - "你好Hello" -> 混合字符
*/

// MARK: - 使用说明

/*
 在 Xcode 中使用这些测试用例：

 1. 将测试用例数据复制到测试文件中
 2. 使用 SubtitleTextParser.parse() 方法解析
 3. 验证返回的 SubtitleText 结构

 示例代码：

 let parser = SubtitleTextParser.self
 let result = parser.parse("这是中文 ||| This is English")

 // 验证结果
 assert(result.isBilingual == true)
 assert(result.primary == "这是中文")
 assert(result.secondary == "This is English")
*/
