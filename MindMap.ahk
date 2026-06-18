#Requires AutoHotkey v2

; 脚本启动时自动请求管理员权限
if !A_IsAdmin {
    try Run '*RunAs "' A_ScriptFullPath '"'  ; 关键语句
    ExitApp
}

::email::
{
    sendtext("YourName@example.com")
}
::myphone::
{
    sendtext("1XXXXXXXXXX")
}
#HotIf
#HotIf WinActive("ahk_class Qt662QWindowIcon")
!1::
{
    send("客观{Enter}")
}
!2::
{
    send("主观{Enter}")
}
!3::
{
    send("真题{Enter}")
}
!4::
{
    send("金题{Enter}")
}
!5::
{
    send("口诀{Enter}")
}
!6::
{
    send("思维导图{Enter}")
}
!7::
{
    send("图表{Enter}")
}
!8::
{
    send("问答{Enter}")
}
#HotIf
#HotIf WinActive("ahk_class Chrome_WidgetWin_1")
!c::
{
    sendtext("#e9effd")
}
#HotIf
#HotIf
#t::
{
    ; 此映射键无特殊功能，仅用于测试
    strResult := "test string"
    strResult := RegExReplace(strResult, ",+[\x{2000}-\x{200A}\x{3000} 	]*(?=[\p{Han}])", "，")
    msgbox(strResult)
}
!z::
{
    sendtext(FormatTime(A_Now, "yyyyMMdd"))
}
!a::
{
    strResult := A_Clipboard
    ; strResult := RegExReplace(strResult, "i)[^ABCD]*([ABCD、､，, ]{1,8}).*", "综上所述，本题答案为：$U1。")
    ; 上述代码基本满足需要，但是其不能格式化不规范的答案。
    if (RegExMatch(strResult, "i)[^ABCD]*(?<answer>[ABCD、､，,　 项]{1,8}).*", &Match)) {
        strResult := CorrectAnswer(Match.answer)
        strResult := format("综上所述，本题答案为：{1}。", strResult)
    }
    ; sendtext(strResult) ; 此语句在anki中不正常，只好用下面的笨办法代替。
    A_Clipboard := strResult
    send("^v")
}
CorrectAnswer(answer) {
    ; 此函数的作用是将选择题的答案格式化为[ABCD]样式——转为大写并排好序，不超过4个字母。
    ; 移除所有非abcdABCD字母字符
    strResult := RegExReplace(answer, "i)[^a-d]+")
    ; 转换为大写
    strResult := StrUpper(strResult)
    ; 转换字符串为数组，以便添加分隔符号
    charArray := StrSplit(strResult)
    ; 将数组转为字符串同时添加分隔符号，为排序做准备
    strResult := JoinStrArray(charArray, ",")
    ; 排序，AutoHotkey的排序语法较为怪异，竟然不能直接对数组排序，而要转为字符串再排序
    strResult := Sort(strResult, "C0 U D,")
    ; 删除结果中的分隔符号
    strResult := StrReplace(strResult, ",")
    return strResult
}
; !b::
; {
;     send("一些测试文字，另一些文字；最后一部分文字。")
; AutoHotkey总是会将中文标点输出两次，并删除中文标点后的汉字。
; }
!v::
{
    sendtext("✅")
}
!x::
{
    sendtext("❌")
}
!d::
{
    sendtext("📌")
}
!e::
{
    sendtext("❗")
}
!q::
{
    sendtext("❓")
}
!f::
{
    sendtext("🚩")
}
!s::
{
    sendtext("🆚")
}
!t::
{
    sendtext("🔺")
}
!r::
{
    sendtext("在的，请讲。")
}
!o::
{
    sendtext("🆗")
}
#a::
{
    send("^a")
}
#x::
{
    send("^x")
}
#c::
{
    send("^c")
}
#Esc::
{
    send("#+{Left}")
}
#d::
{
    strResult := A_Clipboard
    strResult := LintChinese(strResult)
    strResult := PersonalHabit(strResult)
    strResult := RTrim(strResult, "-_—､,;:｡、，；：。`r`n`t❗️‼️ 　") . "。"
    A_Clipboard := strResult
    send("^v")
}
#f::
{
    ; 不集成“Ctrl+x剪切快捷键”的原因是：有时并不是在原地增加“分号”，而是从其它文档中复制的文字后加分号，为了使代码更通用，所以不集成“Ctrl+x剪切快捷键”。
    strResult := A_Clipboard
    strResult := LintChinese(strResult)
    strResult := PersonalHabit(strResult)
    strResult := RTrim(strResult, "-_—､,;:｡、，；：。`r`n`t❗️‼️ 　") . "；"
    A_Clipboard := strResult
    send("^v")
}
#g::
{
    strResult := A_Clipboard
    strResult := LintChinese(strResult)
    strResult := PersonalHabit(strResult)
    strResult := RTrim(strResult, "-_—､,;:｡、，；：。`r`n`t❗️‼️ 　") . "，"
    A_Clipboard := strResult
    send("^v")
}
#v::
{
    strResult := A_Clipboard
    strResult := LintChinese(strResult)
    strResult := PersonalHabit(strResult)
    strResult := UnifySN(strResult)
    A_Clipboard := strResult
    send("^v")
}
#s::
{
    strResult := A_Clipboard
    strResult := LintChinese(strResult)
    strResult := PersonalHabit(strResult)
    strResult := BreakParagraphBySentence(strResult)
    strResult := PersonalHabit(strResult)
    strResult := UnifySN(strResult)
    A_Clipboard := strResult
    send("^v")
}
#;::
{
    strResult := A_Clipboard
    strResult := LintChinese(strResult)
    strResult := PersonalHabit(strResult)
    strResult := BreakParagraphBySemicolon(strResult)
    strResult := UnifySN(strResult)
    A_Clipboard := strResult
    send("^v")
}
#,::
{
    strResult := A_Clipboard
    strResult := LintChinese(strResult)
    strResult := PersonalHabit(strResult)
    strResult := BreakParagraphByComma(strResult)
    A_Clipboard := strResult
    send("^v")
}
#-::
{
    strResult := A_Clipboard
    strResult := LintChinese(strResult)
    strResult := PersonalHabit(strResult)
    strResult := BreakParagraphByHyphen(strResult)
    A_Clipboard := strResult
    send("^v")
}
#?::
{
    strResult := A_Clipboard
    strResult := LintChinese(strResult)
    strResult := PersonalHabit(strResult)
    strResult := BreakParagraphToItems(strResult)
    A_Clipboard := strResult
    send("^v")
}
#/::
{
    strResult := A_Clipboard
    strResult := LintChinese(strResult)
    strResult := PersonalHabit(strResult)
    strResult := BreakParagraphByChineseComma(strResult)
    A_Clipboard := strResult
    send("^v")
}
#q::
{
    ; 此脚本用于将剪贴板中的文本用引号包裹起来，在此之前会先移除端部不成对的引号和成对的引号
    strResult := A_Clipboard
    strResult := Ltrim(strResult, "”、,：；。？！､,:;｡?!)）]】}　 `r`n\t")
    strResult := Rtrim(strResult, "“(（[【{　 `r`n\t")

    quotePattern := "[`"“]([^`"“”]|(?R))*[`"”]"

    if (RegExMatch(strResult, quotePattern)) {
        while (RegExMatch(strResult, quotePattern, &MatchPair1)) {
            originalLength := StrLen(strResult)

            startPos := 1
            firstMatchStartPos := 0
            lastMatchEndPos := 0
            while RegExMatch(strResult, quotePattern, &MatchPair2, startPos) {
                if (firstMatchStartPos = 0) {
                    firstMatchStartPos := MatchPair2.Pos
                }
                startPos := MatchPair2.Pos + MatchPair2.Len
                lastMatchEndPos := startPos - 1
            }

            leftPart := SubStr(strResult, 1, firstMatchStartPos - 1)
            middlePart := SubStr(strResult, firstMatchStartPos, lastMatchEndPos - firstMatchStartPos + 1)
            rightPart := SubStr(strResult, lastMatchEndPos + 1)

            leftPart := Ltrim(leftPart, '"“ 　`r`n\t')
            if (MatchPair1.0 == middlePart) {
                middlePart := SubStr(middlePart, 2, StrLen(middlePart) - 2)
            }
            rightPart := Rtrim(rightPart, '"” 　`r`n\t')

            strResult := leftPart . middlePart . rightPart

            newLength := StrLen(strResult)
            if (originalLength = newLength)
                break
        }
    } else {
        strResult := Trim(strResult, '"“” 　`r`n\t')
    }

    strResult := Format("“{1}”", strResult)

    A_Clipboard := strResult
    send("^v")
}

#b::
{
; 此脚本用于将剪贴板中的文本用括号包裹起来，在此之前会先移除端部不成对的括号和成对的括号
    strResult := A_Clipboard
    strResult := Ltrim(strResult, "”、,：；。？！､,:;｡?!)）]】}　 `r`n\t")
    strResult := Rtrim(strResult, "“(（[【{　 `r`n\t")
    pairPattern := "[（(]([^（）()]|(?R))*[)）]"
     if (RegExMatch(strResult, pairPattern)) {
        while (RegExMatch(strResult, pairPattern, &MatchPair1)) {
            originalLength := StrLen(strResult)
            ; 使用循环查找所有匹配项, 因为一个字符串中有可能有多个括号对，不能简单的用匹配的开头或结尾来判断可移除的端部的不成对括号数量。
            startPos := 1
            firstMatchStartPos := 0
            lastMatchEndPos := 0
            while RegExMatch(strResult, pairPattern, &MatchPair2, startPos) {
                if (firstMatchStartPos = 0) {
                    ; 如果是第一个匹配，记录起始位置
                    firstMatchStartPos := MatchPair2.Pos
                }
                ; 更新下一次搜索的起始位置，并记录最后一个匹配的结束位置
                startPos := MatchPair2.Pos + MatchPair2.Len
                lastMatchEndPos := startPos - 1
            }
            leftPart := SubStr(strResult, 1, firstMatchStartPos - 1)
            middlePart := SubStr(strResult, firstMatchStartPos , lastMatchEndPos - firstMatchStartPos + 1 )
            rightPart := SubStr(strResult, lastMatchEndPos + 1)

            ; 对左侧字符串进行 Ltrim 处理，删除多余的左括号
            leftPart := Ltrim(leftPart, "(（ 　`r`n\t")

            if (MatchPair1.0 == middlePart) {
                middlePart := SubStr(middlePart, 2, StrLen(middlePart) - 2)
            }

            ; 对右侧字符串进行 Rtrim 处理，删除多余的右括号
            rightPart := Rtrim(rightPart, ")） 　`r`n\t")

            ; 拼接处理后的字符串
            strResult := leftPart . middlePart . rightPart
            ; 上述将字符串分成三段，再Ltrim左端字符串、Rtrim右端字符串的方式，可以避免错误的移除原本成对的括号；
            ; 例如“（（测试文本）”这一字符串，如果判断出括号对没有从字符串的左端开始匹配就Ltrim该字符串，则会将将该字符串处理成“测试文本）”，而这显然不是正确结果。
            newLength := StrLen(strResult)
            if (originalLength = newLength) ; 如果长度未变化，则停止循环
                break
        }
    } else {
        strResult := Trim(strResult, "(（)） 　`r`n\t")
    }
    strResult := Format("（{1}）", strResult)
    A_Clipboard := strResult
    send("^v")
}
#z::
{
    strResult := A_Clipboard
    strResult := RegExReplace(strResult, "(?<=[。”！？])(?=[\(（]\s*\d+\s*[\)）])", "`r`n")
    strResult := RegExReplace(strResult, "(?<=。)(?=综上)", "`r`n")
    strResult := LintChinese(strResult)
    strResult := PersonalHabit(strResult)
    A_Clipboard := strResult
    send("^v")
}
global COUNT := 0
; COUNT用于给字符串前加序号时的计数器
global lastruntime := A_TickCount
interval := 2 * 60000
#0::
{
    global COUNT
    global lastruntime
    lastruntime := A_TickCount
    ; 计数器归零
    COUNT := 0
}
#+=::
{
    global COUNT
    global lastruntime
    if (A_TickCount - lastruntime > interval)
    {
        ; 计数器归零
        COUNT := 0
    }
    lastruntime := A_TickCount
    ; 计数器自增一
    COUNT++
}
#=::
{
    global COUNT
    global lastruntime
    if (A_TickCount - lastruntime > interval)
    {
        ; 计数器归零
        COUNT := 0
    }
    lastruntime := A_TickCount
    ; 计数器自减一
    COUNT--
    if (COUNT < 0)
    {
        COUNT := 0
    }
}
#1::
{
    global COUNT
    global lastruntime
    if (A_TickCount - lastruntime > interval)
    {
        ; 计数器归零
        COUNT := 0
    }
    lastruntime := A_TickCount
    ; 每调用一次，计数器就自增一，同时将此序号加在字符串前。
    COUNT++
    strResult := A_Clipboard
    strResult := Trim(strResult, "`r`n`t 　")
    strResult := RegExReplace(strResult, "^\s*(\d+\s*[\.、,，。　]+)+\s*", "")
    strResult := RegExReplace(strResult, "\s*[r`n`]+\s*", "`r`n")
    strResult := COUNT . ". " strResult
    strResult := LintChinese(strResult)
    strResult := PersonalHabit(strResult)
    A_Clipboard := strResult
    send("^v")
}
#2::
{
    global COUNT
    global lastruntime
    if (A_TickCount - lastruntime > interval)
    {
        ; 计数器归零
        COUNT := 0
    }
    lastruntime := A_TickCount
    ; 每调用一次，计数器就自增一。
    global COUNT
    COUNT++
    strResult := COUNT . ". "
    A_Clipboard := strResult
    send("^v")
}
global SpecilDigit := [
        ; "0𝟣𝟤𝟥𝟦𝟧𝟨𝟩𝟪𝟫",
        ; "𝟎𝟏𝟐𝟑𝟒𝟓𝟔𝟕𝟖𝟗",
        ; "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡",
        ; "🄁🄂🄃🄄🄅🄆🄇🄈🄉🄊",
        ; 以上几种数字格式用正则"\p{N}"匹配不到，暂时未能实现替换为常规数字的功能。
        "①②③④⑤⑥⑦⑧⑨⑩⑪⑫⑬⑭⑮⑯⑰⑱⑲⑳㉑㉒㉓㉔㉕㉖㉗㉘㉙㉚㉛㉜㉝㉞㉟㊱㊲㊳㊴㊵㊶㊷㊸㊹㊺㊻㊼㊽㊾㊿",
        "➀➁➂➃➄➅➆➇➈➉",
        "⑴⑵⑶⑷⑸⑹⑺⑻⑼⑽⑾⑿⒀⒁⒂⒃⒄⒅⒆⒇",
        "⓵⓶⓷⓸⓹⓺⓻⓼⓽⓾",
        "⒈⒉⒊⒋⒌⒍⒎⒏⒐⒑⒒⒓⒔⒕⒖⒗⒘⒙⒚⒛",
        "❶❷❸❹❺❻❼❽❾❿⓫⓬⓭⓮⓯⓰⓱⓲⓳⓴",
        "➊➋➌➍➎➏➐➑➒➓",
        "０１２３４５６７８９",
        "㈠㈡㈢㈣㈤㈥㈦㈧㈨㈩",
        "㊀㊁㊂㊃㊄㊅㊆㊇㊈㊉",
        "ⅠⅡⅢⅣⅤⅥⅦⅧⅨⅩⅪⅫ",
        "ⅰⅱⅲⅳⅴⅵⅶⅷⅸⅹⅺⅻ",
    ]
global ChineseNumberPattern := "(?:(?:(?<=^|[亿万千零])两(?![十拾])|[〇零]?(?:[一二三四五六七八九壹贰叁肆伍陆柒捌玖貮][十拾佰百仟千]?|[一二三四五六七八九壹贰叁肆伍陆柒捌玖貮十拾])[萬万]?[億亿]*)+|[〇零一二三四五六七八九十壹贰叁肆伍陆柒捌玖拾貮]+)([点點][〇零一二三四五六七八九十壹贰叁肆伍陆柒捌玖拾貮]+)?"
; “两”只能出现在数字的开头以及[亿万千零]后边，要避免错误的将“张三、李四两个自然人。”中的“四两”转换为“42”。
PrefixSN(string)
{
    strResult := string
    strResult := RegexReplace(strResult, "m)^\s*\d+\s*[\.､,、，]\s*", "") ; 去除原行首编号
    strResult := RegexReplace(strResult, "m)^\s*\(?\d+\)\s*", "") ; 去除原行首编号
    global SpecilDigit
    for digit in SpecilDigit
    {
        strResult := RegexReplace(strResult, Format("m)^\s*[{1}][\.､,、，\s]*", digit), "") ; 去除原行首编号
    }
    strResult := RegexReplace(strResult, "m)^[､,;｡?! 、，；。？！　]+", "") ; 去除行首的标点符号
    strResult := RegexReplace(strResult, "m)[､,;｡?! 、，；。？！　]+$", "") ; 去除原行首的标点符号
    strArray := StrSplit(strResult, ["`r`n", "`r", "`n"], " 　`t")
    strArray := Filt(strArray, [""])
    for item in strArray
    {
        head := A_Index . ". "
        tail := A_Index < strArray.Length ? "；" : "。"
        strArray[A_Index] := head . item . tail
    }
    strResult := StrJoin("`r`n", strArray*)
    return strResult
}
#m::
{
    strResult := A_Clipboard
    strResult := PrefixSN(strResult)
    strResult := LintChinese(strResult)
    strResult := PersonalHabit(strResult)
    A_Clipboard := strResult
    send("^v")
}
#n::
{
    strResult := A_Clipboard
    strResult := LintChinese(strResult)
    strResult := PersonalHabit(strResult)
    strArray := StrSplit(strResult, ["`r`n", "`r", "`n"], " 　`t")
    strResult := StrJoin("`r`n", strArray*)
    strResult := PrefixSN(strResult)
    A_Clipboard := strResult
    send("^v")
}
#r::
{
    strResult := A_Clipboard
    strResult := LintChinese(strResult)
    strResult := PersonalHabit(strResult)
    strResult := TrimPrefixAndSuffix(strResult)
    A_Clipboard := strResult
    send("^v")
}
#e::
{
    strResult := A_Clipboard
    strResult := PersonalHabit(strResult)
    strResult := Trim(strResult, "､,;:.?!、，；：。？！`r`n`t 　-_—")
    strResult := Trim(strResult, "❗️‼️")
    A_Clipboard := strResult
    send("^v")
}
#j::
{
    strResult := A_Clipboard
    strResult := Trim(strResult)
    strArray := StrSplit(strResult, ["`r`n", "`r", "`n"], " 　`t")
    strArray := Filt(strArray, [""])
    strResult := StrJoin("、", strArray*)
    strResult := RegexReplace(strResult, "\s*[,;，；]+\s*", "、")
    A_Clipboard := strResult
    send("^v")
}
!n::
{
    strResult := A_Clipboard

    ; 保留数字和换行符（包括 `r, `n, `r`n），其他一律删除
    ; 先把所有换行统一转为一个标记（比如换行符本身），然后只保留数字和换行
    ; 使用正则：[^0-9\r\n] 表示非数字、非回车、非换行的字符
    strResult := RegExReplace(strResult, "[^0-9\r\n]", "")

    ; 分割并重新合并，确保换行统一为 `r`n
    strArray := StrSplit(strResult, ["`r`n", "`r", "`n"])
    strResult := StrJoin("`r`n", strArray*)

    ; 可选：去除空行（如果不需要空行）
    ; strArray := []
    ; Loop strArrayTemp := StrSplit(strResult, "`r`n")
    ; {
    ;     if (A_LoopField != "")
    ;         strArray.Push(A_LoopField)
    ; }
    ; strResult := StrJoin("`r`n", strArray*)

    A_Clipboard := strResult
    Send("^v")
}
StrJoin(Separator, Params*)
{
    startIndex := 1
    endIndex := Params.Length

    ; 移除数组开头的空白项
    while (startIndex <= endIndex && Trim(Params[startIndex]) = "")
        startIndex++

    ; 移除数组末尾的空白项
    while (endIndex >= startIndex && Trim(Params[endIndex]) = "")
        endIndex--

    ; 如果没有剩余元素，则返回空字符串
    if (startIndex > endIndex)
        return ""

    ; 连接字符串，首先添加 startIndex 对应的元素
    strResult := Params[startIndex]
    index := startIndex + 1

    while (index <= endIndex)
    {
        strResult .= Separator . Params[index]
        index++
    }
    return strResult
}
SortArray(arr, unique := true, doTrim := true, reverse := false) {
    ; 如果需要 trim，则先处理所有元素
    if (doTrim) {
        newArr := []
        for i, val in arr
            newArr.Push(Trim(val))
        arr := newArr
    }

    ; 如果需要去重，则用对象过滤重复项
    if (unique) {
        tempMap := Map()
        for i, val in arr
            tempMap[val] := true
        uniqueArr := []
        for key in tempMap
            uniqueArr.Push(key)
        arr := uniqueArr
    }

    ; 排序（升序）
    sorted := []
    for item in arr
        sorted.Push(item)

    ; 如果要逆序，反转数组
    if (reverse)
        sorted := ReverseArray(sorted)

    return sorted
}
; 辅助函数：反转数组
ReverseArray(arr) {
    reversed := []
    count := arr.Length()
    Loop count
        reversed.Push(arr[-A_Index])
    return reversed
}
TraverseUnusualChars(str) {
    characters := []
    index := 1
    while (index <= StrLen(str)) {
        ; 获取当前字符
        char1 := SubStr(str, index, 1)
        code1 := Ord(char1)

        ; 检查是否为高代理项（high surrogate）
        if (code1 >= 0xD800 && code1 <= 0xDBFF) {
            ; 获取下一个字符
            char2 := SubStr(str, index + 1, 1)
            code2 := Ord(char2)

            ; 检查是否为低代理项（low surrogate）
            if (code2 >= 0xDC00 && code2 <= 0xDFFF) {
                ; 合并高代理项和低代理项以创建完整的生僻汉字
                unusualChar := char1 . char2
                index++
            }
        } else {
            unusualChar := char1
        }

        characters.Push(unusualChar)
        index++
    }

    return characters
}

; 从文件中读取映射表并创建字典
; 从文件中读取转换表并创建字典
CreateMappingTable(file) {
    mapping := Map()

    for line in StrSplit(file, "`n", "`r") {
        chars := TraverseUnusualChars(line)
        if (chars.Length == 2) {
            traditionalChar := chars[1]
            simplifiedChar := chars[2]
            mapping[traditionalChar] := simplifiedChar
        }
    }
    return mapping
}

; 替换字符串中的繁体字和异体字
ReplaceTraditionalAndVariant(mapping, input) {
    output := ""
    for i, char in TraverseUnusualChars(input) {
        if (mapping.Has(char)) {
            output .= mapping[char]
        }
        else {
            output .= char
        }
    }
    return output
}

; 脚本启动就生成替换表
fileContent := FileRead("繁简转换对照表.txt", "UTF-8")
mappingTableFromTraditionalAndVariantToSimplified := CreateMappingTable(fileContent)

CorrectErrors(string)
{
    strResult := string
    strResult := StrReplace(strResult, Chr(0x200B)) ; 去除 U+200B（零宽空格）
    ; region ↓ OCR 中常见这些简体字识别为另外一个简体字的繁体字或异体字，所以这些繁体字或异体字应当在转换为简体的规范字前先纠正。
    strResult := StrReplace(strResult, "優", "侵")
    strResult := StrReplace(strResult, "東", "束")
    ; region ↑ OCR 中常见这些简体字识别为另外一个简体字的繁体字或异体字，所以这些繁体字或异体字应当在转换为简体的规范字前先纠正。
    ; region ↓ OCR 中常见的繁体字、异体字改为简体的规范字
    strResult := ReplaceTraditionalAndVariant(mappingTableFromTraditionalAndVariantToSimplified, strResult)
    ; region ↑ OCR 中常见的繁体字、异体字改为简体的规范字
    ; region ↓ OCR 中常见的错误补正
    strResult := RegExReplace(strResult, "[ロ口][诀决]", "口诀") ; OCR中常出现的"ロ诀"（“ロ”不是汉字“口”）替换为汉字“口诀”，在此自动改正。
    strResult := StrReplace(strResult, "栽定", "裁定")
    strResult := StrReplace(strResult, "仲栽", "仲裁")
    strResult := StrReplace(strResult, "座当", "应当")
    strResult := StrReplace(strResult, "彳亍", "行")
    strResult := StrReplace(strResult, "白勺", "的")
    strResult := StrReplace(strResult, "不熊", "不能")
    strResult := StrReplace(strResult, "工作旦", "工作日")
    strResult := StrReplace(strResult, "着作", "著作")
    strResult := StrReplace(strResult, "エ", "工")
    strResult := StrReplace(strResult, "⼀", "一") ; 被替换的字符在部分编辑器中无法正常显示，它是异体汉字，OCR的文档中常出现，非错误代码，慎删
    strResult := StrReplace(strResult, "⼆", "二") ; 被替换的字符在部分编辑器中无法正常显示，它是异体汉字，OCR的文档中常出现，非错误代码，慎删
    strResult := StrReplace(strResult, "⼋", "八") ; 被替换的字符在部分编辑器中无法正常显示，它是异体汉字，OCR的文档中常出现，非错误代码，慎删
    strResult := StrReplace(strResult, "⼗", "十") ; 被替换的字符在部分编辑器中无法正常显示，它是异体汉字，OCR的文档中常出现，非错误代码，慎删
    strResult := StrReplace(strResult, "⺠", "民") ; 被替换的字符在部分编辑器中无法正常显示，它是异体汉字，OCR的文档中常出现，非错误代码，慎删
    strResult := StrReplace(strResult, "️⬆️", "↑")
    strResult := StrReplace(strResult, "⬇️", "↓")
    strResult := StrReplace(strResult, "➡️", "→")
    strResult := StrReplace(strResult, "⬅️", "←")
    strResult := RegExReplace(strResult, "mi)\bo$", "。") ; OCR中常将行尾出现的中文句号识别为字母O，在此自动改正为句号。
    strResult := RegExReplace(strResult, "(?<=[､,:;?!、，：；。？！])\.", "") ; OCR的标点后常出现一个奇怪的“.”，需要删除。
    strResult := RegExReplace(strResult, "mi)^[(（][―-][)）]", "（一）") ; OCR中常将行首出现的"（一）"中间的字符应该是是汉字“一”，在此自动改正。
    strResult := RegExReplace(strResult, "mi)^[(（]ハ[)）]", "（八）") ; OCR中常将行首出现的"（ハ）"中间的字符应该是汉字“八”，在此自动改正。
    strResult := RegExReplace(strResult, "(\d+)\?\??", "$1`%") ; WPS的OCR常将“%”识别为“??”, 在此处改正。
    ; 以上代码只会将问号替换为%, 但是WPS的OCR常常还会吞掉百分号%后的一个字符，常见且可以明显识别出错误的字符是“的股份中的‘的’”、“以上以下开头的‘以’”，通过以下两行代码继续改正
    strResult := RegExReplace(strResult, "(?<=\d%)\s*(?=(?:份额|股[东份权])(?!的))", " 的") ; 添加被吞掉的空格及“的”字，同时避免将“持有%1股权的股东张三”替换为“持有%1的股权的股东张三”
    strResult := RegExReplace(strResult, "(?<=\d%)\s*(?=[上下])", "  以") ; 添加被吞掉的空格及“以”字。
    ; endregion ↑ OCR 中常见的错误补正
    ; region ↓ 不正确且可自动补正的标点组合
    strResult := RegExReplace(strResult, "([､,;?!、，；：。？！])(?:\g{1})+", "$1") ; 部分重复出现的相同标点符号一定是错误的，删除重复的标点。例如："，，"，"。。"，"；；"。
    strResult := RegExReplace(strResult, "m)^[”､,;:.?!、，；：。？！ 　]+", "") ; 行首出现这些标点一定是错误的，删除之。
    strResult := RegExReplace(strResult, "m)[“ 　]+$", "") ; 行尾出现这些标点一定是错误的，删除之。
    ; endregion ↑ 不正确且可自动补正的标点组合
    ; region ↓ 修复多层书名号中的内层的书名号(包括不规范的尖括号)为单书名号, 《A《BC》《D<EF>》GHKL》→《A〈BC〉〈D〈EF〉〉GHKL》
    currentPos := 1
    while (RegExMatch(strResult, "《((?:[^《》]|(?R))+)》", &MatchA, StartingPos := currentPos))
    {
        tempRes := MatchA.1
        while (RegExMatch(tempRes, "《((?:[^《》]|(?R))+)》", &MatchB) or RegExMatch(tempRes, "<((?:[^<>]|(?R))+)>", &MatchB))
        {
            tempRes := RegExReplace(tempRes, MatchB.0, "〈" . MatchB.1 . "〉", , 1, MatchB.Pos)
        }
        strResult := RegExReplace(strResult, MatchA.0, "《" . tempRes . "》",  , 1, MatchA.Pos)
        currentPos := MatchA.Pos + MatchA.Len
    }
    ; region ↑ 修复多层书名号中的内层的书名号(包括不规范的尖括号)为单书名号, 《A《BC》《D<EF>》GHKL》→《A〈BC〉〈D〈EF〉〉GHKL》
    return strResult
}
UnifySN(string)
{
    strResult := string
    ; region ↓ 行首表示序号格式统一
    global SpecilDigit
    for digit in SpecilDigit
    {
        Loop StrLen(digit) {
            ; msgbox(SubStr(digit, A_Index, 1))
            strResult := RegExReplace(strResult, Format("m)^\s*{1}\s*", SubStr(digit, A_Index, 1)), Format("{1}. ", A_Index))
        }
    }
    RomanDigit := [
        "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI", "XII", "XIII" , "XIV" , "XV" , "XVI" , "XVII" , "XVIII" , "XIX" , "XX" , "XXI" , "XXII" , "XXIII" , "XXIV" , "XXV" , "XXVI" , "XXVII" , "XXVIII" , "XXIV" , "XXX"
    ]
    Loop RomanDigit.Length {
        strResult := RegExReplace(strResult, Format("mi)^[\s`t\(（【]*{1}[\.\s，、；：,､`;:\)）】]+", RomanDigit[A_Index]), Format("{1}. ", A_Index))
    }
    ; 将“第1，”、“第2，”“其1，”、“其2，”等序号样式规范为“1. ”“2. ”
    While (RegExMatch(strResult, "m)^[第其]\s*(?<Digit>\d+)\s*[，、；：,､`;:]+", &Match))
    {
        strResult := RegexReplace(strResult, RegExReplace(Match.0, "[()]", "\${0}"), Match.Digit . ". ", , 1, Match.Pos)
    }
    global ChineseNumberPattern
    While (RegExMatch(strResult, Format("m)^[\s`t第其\(（【]*(?<ChineseNumber>{1})[\s，、；：,､`;:\)）】]+", ChineseNumberPattern), &Match))
    {
        strResult := RegexReplace(strResult, RegExReplace(Match.0, "[()]", "\${0}"), ConvertChineseNumber2Digits(Match.ChineseNumber) . ". ", , 1, Match.Pos)
    }
    While (RegExMatch(strResult, Format("m)^其?(?<ChineseNumber>{1})[是为来]", ChineseNumberPattern) , &Match))
    {
        strResult := RegexReplace(strResult, Match.0, ConvertChineseNumber2Digits(Match.ChineseNumber) . ". ", , 1, Match.Pos)
    }
    strResult := RegExReplace(strResult, "m)^\s*(\d+)\s*[\.、､]+\s*", "${1}. ") ; 规范句首的序号及分割符
    ; endregion ↑ 行首表示序号格式统一
    return strResult
}
TranslateChineseNumbersBeforeQuantifier(string)
{
    strResult := string
    global ChineseNumberPattern
    ; While (RegExMatch(strResult, Format("(?<!每)(?<ChineseNumber>{1})(?<Unit>[类件户届级次套步辆位家名部章款项条种倍人岁个类年月日天点]|周岁|小时|[万亿]元|(?<![万亿])元)", ChineseNumberPattern), &Match))
    ; While (RegExMatch(strResult, Format("(?<ChineseNumber>{1})(?<Unit>[期大派座块只张支笔票份类件户届级次套步台辆位家名部章款项条颗种倍人岁个类年月日天]|周岁|小时|[万亿]元|(?<![万亿])元)", ChineseNumberPattern), &Match))
    ; {
    ;     new := Format(" {1} {2}", ConvertChineseNumber2Digits(Match.ChineseNumber), Match.Unit)
    ;     strResult := RegexReplace(strResult, Match.0, new, , 1, Match.Pos)
    ; }
    ; 下边这段代码可以转换包括多个中文数字但只有一个单位的字符串中的多个中文数字，例如："第十二、十五、一百二十三条"中的 3 个数字均能够转换，但是上边的代码只能够将"一百二十三"转换为数字，暂时不将其删除。
    ; While (RegExMatch(strResult, Format("(?<ChineseNumbers>({1}[､、 　`t]*)+)(?<Unit>[期大派座块只张支笔票份类件户届级次套步台辆位家名部章款项条颗种倍人岁个类年月日天]|周岁|小时|[万亿]元|(?<![万亿])元)", ChineseNumberPattern), &Match))
    ; {
        ; ChineseNumbers := StrSplit(Match.ChineseNumbers, ["､", "、"], " 　`t")
        ; Loop ChineseNumbers.Length {
            ; ChineseNumbers[A_Index] := ConvertChineseNumber2Digits(ChineseNumbers[A_Index])
        ; }
        ; new := Format(" {1} {2}", StrJoin("、", ChineseNumbers*), Match.Unit)
        ; strResult := RegexReplace(strResult, Match.0, new, , 1, Match.Pos)
    ; }
    ; 下面的代码是上述两段被注释的代码的组合，能够转换这种格式的中文数字，例如："第十二、第十五、二十一至二十六，第三十二到四十一以及第一百二十三条"中的 所有中文数字
    while (RegExMatch(strResult, Format("(?<!([几十百千万]分之))(?<!几)(?<ChineseNumbers>(?:第?{1}(?:以?及|[与至到~～—､、,， 　`t-])+)*第?{1}[ 　\t]*)(?<Unit>[头间匹处期大派层座轮块张笔票份类件户届级次套杯位步包台档辆栋股瓶枚罐盒包箱吨位家名部章款项节条课讲颗米种倍人岁歲句个类月日天秒元]|年(?!龄)|周岁?|小时|分钟|千米|公?[里斤尺]|海里|根(?!据)|只(?![要能可是])|支(?![付票])|(?<=[十百千万亿])[多余])", ChineseNumberPattern), &Match1))
    {
        ; 外层循环用来找到位于指定计量单位前的一个或多个中文数字
        ; 内层循环用来遍历多个数字中的每一个中文数字，将其转换为阿拉伯数字，但是在转换前要去除每一个数字结尾的“万亿”字样，避免生成的数字结尾出现过多的0，不利于阅读。
        new := Match1.0
        While (RegExMatch(new, Format("(?<ChineseNumber>{1})", ChineseNumberPattern), &Match2))
        {
            num := RTrim(Match2.ChineseNumber, "萬万億亿")
            new := RegexReplace(new, num, ConvertChineseNumber2Digits(num), , 1, Match2.Pos)
        }
        strResult := RegexReplace(strResult, Match1.0, new, , 1, Match1.Pos)
    }
    strResult := RegexReplace(strResult, "第\s*3\s*人", "第三人") ; 修复上面代码改错的文字
    strResult := RegexReplace(strResult, "(?<!主)张\s*3(?!\d)\s*", "张三")     ; 修复上面代码改错的文字, 同时避免将“向乙公司主张30万元债权”中的“张3”替换为“张三”
    strResult := RegexReplace(strResult, "李\s*4\s*", "李四")     ; 修复上面代码改错的文字
    strResult := RegexReplace(strResult, "王\s*5\s*", "王五")     ; 修复上面代码改错的文字
    strResult := RegexReplace(strResult, "赵\s*6\s*", "赵六")     ; 修复上面代码改错的文字
    strResult := RegexReplace(strResult, "唯\s*11\s*", "唯一一")
    strResult := RegexReplace(strResult, "唯\s*1\s*(?!\d)", "唯一")
    strResult := RegexReplace(strResult, "\b\s*0\s*部?件", "零件")
    strResult := RegexReplace(strResult, "\b\s*1\s*次性", "一次性")
    strResult := RegexReplace(strResult, "\b\s*1\s*大堆", "一大堆")
    strResult := RegexReplace(strResult, "\b\s*1\s*条龙", "一条龙")
    strResult := RegexReplace(strResult, "\b\s*1\s*人(?=(公司|有限公司|有限责任公司))", "一人")
    strResult := RegexReplace(strResult, "\b\s*1\s*步到位", "一步到位")
    strResult := RegexReplace(strResult, "只身\s*1\s*人", "只身一人")
    strResult := RegexReplace(strResult, "睁\s*1\s*只眼闭\s*1\s*只眼", "睁一只眼闭一只眼")
    strResult := RegexReplace(strResult, "\b\s*1\s*步步", "一步步")
    ; 在民法、刑法、行政法、刑诉法、理论法中有“两步走”、“三步走”、“四步走”等专有名词，在此处予以更正。
    strResult := RegexReplace(strResult, "\b\s*2\s*步走", "两步走")
    strResult := RegexReplace(strResult, "\b\s*3\s*步走", "三步走")
    strResult := RegexReplace(strResult, "\b\s*4\s*步走", "四步走")
    strResult := RegexReplace(strResult, "\b\s*3\s*轮车", "三轮车")
    strResult := RegexReplace(strResult, "\b\s*3\s*头六臂", "三头六臂")
    strResult := RegexReplace(strResult, "\b\s*3\s*天三夜", "三天三夜")
    strResult := RegexReplace(strResult, "\b\s*4\s*周无人", "四周无人")
    strResult := RegexReplace(strResult, "\b\s*5\s*大三粗", "五大三粗")
    strResult := RegexReplace(strResult, "(\d+)\s*旦", "${1}日")
    strResult := RegexReplace(strResult, "([有无])独\s*3\s*", "${1}独三")
    strResult := RegexReplace(strResult, "m)(?<=^|[。？！“”])1\s*天", "一天")
    strResult := RegexReplace(strResult, "m)(?<=^|[，。？！“”])1\s*个(?=[也都])", "一个")
    strResult := RegexReplace(strResult, "(?<=[了有的在于再省市县乡区州又是非这那哪某进退上下前后高低新另从每属]|其中|任何|另外|只有|只要|相当|(?<![责担])任|(?<![行])为|(?<!关)系|(?<!合)同)\s*1(?!(?:[\/\.]?\d)|[%‰‱年月日])", "一") ; (?!\/?\d) 中的“\/?”不可省略，避免错误的将“增资决议的 1/3 的比例要求”、“增加的 1.5 亿元”、“持股比例为 1%”中的“1”替换为“一”
    strResult := RegexReplace(strResult, "为一(?= - \d)", "为 1") ; 仅仅是为了修正上一行代码将“为 1 - 3 小时不等”替换为“为一 - 3 小时不等”的错误，因为暂无好办法在上一行的正则中避免将“为 1 - 3 小时不等”替换为“为一 - 3 小时不等”
    PercentMap := Map("百", "%", "千", "‰", "万", "‱")
    While (RegExMatch(strResult, Format("(?<Percent>[百千万])分之(?<ChineseNumber>{1})", ChineseNumberPattern) , &Match))
    {
        new := Format(" {1}{2} ", ConvertChineseNumber2Digits(Match.ChineseNumber), PercentMap[Match.Percent])
        strResult := RegexReplace(strResult, Match.0, new, , 1, Match.Pos)
    }
    While (RegExMatch(strResult, Format("(?<Denominator>{1})(分之)(?<Numerator>{1})", ChineseNumberPattern) , &Match))
    {
        new := Format(" {1}/{2} ", ConvertChineseNumber2Digits(Match.Numerator), ConvertChineseNumber2Digits(Match.Denominator))
        strResult := RegexReplace(strResult, Match.0, new, , 1, Match.Pos)
    }
    strResult := LintChinese(strResult)
    return strResult
}
PersonalHabit(string)
{
    strResult := string
    ; 根据个人的习惯处理从PDF中复制的一些文字，方便制作思维导图
    strResult := LTrim(strResult, "`r`n`t 　]］」』〗】)〕﹞❳⦘）､,;｡!?-、，；。！？—")
    strResult := RTrim(strResult, "`r`n`t 　[［「『〖【(（〔﹝❲⦗")
    strResult := RegExReplace(strResult, "m)^([又再比譬诸例]如|例(?!外)[子 　\d]*|[范示案]例|举例说明)[　\s、，：； ､,:;\]】」]*", "范例：")
    strResult := RegExReplace(strResult, "m)^[\[［「『〖【〔﹝❲⦗]?(例?题\s*\d+|例\s*\d*|举例说明)\s*[\]］」』〗】〕﹞❳⦘]?", "范例：") ; “题”字在文本中经常出现，如果都替换为“范例”并不合适，只替换“题 1”字样为“范例”更准确。
    ; strResult := RegExReplace(strResult, "股东(?<da>大)?会(?:[､、,，]+[ 　]*|或者?)股东(?(da)|大)会", "股东（大）会")
    strResult := RegExReplace(strResult, "股东（大）会|股东大会|股东(?<da>大)?会(?:[､、,，]+[ 　]*|或者?)股东(?(da)|大)会", "股东会") ; 2024 生效的公司法中已经不区分股东会或股东大会，因此统一改为“股东会”。
    strResult := RegExReplace(strResult, "m)^(\.|\s)+", "")
    strResult := RegExReplace(strResult, "(?<!\d)\.{3}", "…")
    strResult := RegExReplace(strResult, "&\s?(项?(?:正确|错误))", "A ${1}") ; OCR中常将大写字母A识别为字符&，此处予以更正。
    strResult := RegExReplace(strResult, "c\s?(项?(?:正确|错误))", "C ${1}") ; OCR中常将大写字母C识别为小写字母c，此处予以更正。
    strResult := RegExReplace(strResult, "m)^\s*[（(\[［「『〖【〔﹝❲⦗]*\s*(\d+)\s*[)）\]］」』〗】〕﹞❳⦘]+[\.\s､、]*", "${1}. ")
    strResult := RegExReplace(strResult, "m)^[\[［「『〖【〔﹝❲⦗]?(牛刀小试|特别提示|总结|(?:记忆)?口诀)[\]］」』〗】〕﹞❳⦘]", "【${1}】")
    if (RegExMatch(strResult, "i)^[abcd ]{1,6}$", &Match)) ; 思维导图中少部分选择题的答案是以独立节点的形式出现，且为小写，将其修改为大写。
    {
        strResult := StrUpper(RegexReplace(Match.0, "\s+", ""))
    }
    if (RegExMatch(strResult, "mi)^(\d+\s*)?A(\.?\s*)", &MatchAdot)
    and RegExMatch(strResult, "mi)^(\d+\s*)?B(\.?\s*)", &MatchBdot)
    and RegExMatch(strResult, "mi)^(\d+\s*)?C(\.?\s*)", &MatchCdot)
    and RegExMatch(strResult, "mi)^(\d+\s*)?D(\.?\s*)", &MatchDdot)
    and !RegExMatch(strResult, "mi)^(\d+\s*)?E(\.?\s*)", &MatchEdot)
    ) {
        ; 如果刚好有四行分别以A., B., C., D.开头，则判断剪贴板中是一道选择题的题干，则将选项后的点删除，统一格式。
        ; 此外，新浪微博中复制到的选择题的选项前常常包括投票数量的数字，如：“25 A.”这里一并删除。
        strResult := RegexReplace(strResult, MatchAdot.0, "A ")
        strResult := RegexReplace(strResult, MatchBdot.0, "B ")
        strResult := RegexReplace(strResult, MatchCdot.0, "C ")
        strResult := RegexReplace(strResult, MatchDdot.0, "D ")
    }
    strResult := RegExReplace(strResult, "m)^((?:选项)?[✅❌ ]*[ABCD]{1,4}[✅❌ ]*(?:正确|错误|项正确|项错误|选项正确|选项错误|项|选项))。", "$1，") ; 修改孟献贵考前100题答案风格。
    strResult := RegexReplace(strResult, "m)^想一想$", "") ; 新浪微博中复制到的选择题的选项部分前带有“想一想”字样，一并删除。
    strResult := CorrectErrors(strResult)
    strResult := TranslateChineseNumbersBeforeQuantifier(strResult)
    if (RegExMatch(strResult, "\s*[\(（]20\d{2}(?:\s*[\p{Han}]{1,5})?(?:\s*-\s*\d{1,3}){2,3}(，[\p{Han}]{1,5})?[\)）]", &MatchQuestionNumber)) {
        ; 代码常常在题目编号中添加空格，而这些空格是不必要的，例如：“2020 金题 - 2 - 1 - 41”、“(2008 - 3 - 51,多)”，
        ; 下边这行代码可以去除中间的空格、换行，顺便去除“(2020-3-15)”前的空白（主要是换行符号）。
        ; 以下替换是将上述if条件中的匹配到的字符串替换为新字符串，谨慎使用正则，因为上述匹配中带有圆括号，而圆括号在正则中表示分组。
        strResult := StrReplace(strResult, MatchQuestionNumber.0, RegexReplace(MatchQuestionNumber.0, "[`r`n`s]+", ), 0, ,)
    }
    strResult := RegexReplace(strResult, "m)（(\d{4})\s*年\s*[·•]\s*(卷[一二三四])\s*[·•]\s*(\d{1,3})\s*题）", "（$1 年 • $2 • $3 题）") ; 将“（2007 年·卷一·1 题）”规范为“（2007 年 • 卷一 • 1 题）”。
    ; 刑诉考前100题深入拓展
    strResult := RegexReplace(strResult, "(?<=[)）])[①②③④⑤⑥⑦⑧⑨⑩⑪⑫⑬⑭⑮⑯⑰⑱⑲⑳](?=。)", "")
    strResult := RegexReplace(strResult, "^√。", "✅正确。")
    strResult := RegexReplace(strResult, "^[×x]。", "❌错误。")
    strResult := FormatTagsOfExampleText(strResult)
    return strResult
}
BreakParagraphBySentence(string)
{
    strResult := string
    strResult := RegExReplace(strResult, "[`r`n]+", "`r`n")
    ; 将长段落按照句子分成短的段落。
    ; strResult := RegExReplace(strResult, "[`r`n`s]*(”?[。！？]+”?)[`r`n`s]*", "$1`r`n")
    ; 上边这行代码会在所有的[。！？]后都加个换行符号，包括“”《》（）【】这些符号中间的字符；
    ; 而下方的代码则可以忽略“”《》（）【】这些符号包裹的字符中出现的[。！？]
    strArray := []
    While (RegExMatch(strResult, "(?<pair>“(?:[^“”]|(?R))+”|‘(?:[^‘’]|(?R))+’|（(?:[^（）]|(?R))+）|【(?:[^【】]|(?R))+】|《(?:[^《》]|(?R))+》|〈(?:[^〈〉]|(?R))+〉|\((?:[^()]|(?R))+\))" , &Match))
    {
        strArray.Push(RegExReplace(SubStr(strResult, 1, Match.Pos-1), "[`r`n`s]*([。！？]+)[`r`n`s]*", "$1`r`n"))
        strArray.Push(Match.0)
        strResult := SubStr(strResult, Match.Pos+Match.Len)
        if (SubStr(strArray[-1], -1) = "”" and RegExMatch(strArray[-1], "[,:;｡!?，：；。！？]") and (strResult = "" or (not InStr("､,:;｡!?、，：；。！？“", SubStr(strResult, 1, 1))))) {
        ; 如果引号中有，；。！？等标点符号，且下一句的开头不是以标点符号开头，则断定右引号处是句子结尾；目的是避免在这样的引号后断行：甲村村委会签订了“不享受本村村民待遇”的“入户协议”。
            strArray.Push("`r`n")
        }
    }
    strArray.Push(RegExReplace(strResult, "[`r`n`s]*([。！？]+)[`r`n`s]*", "$1`r`n"))
    strResult := StrJoin("", strArray*)
    ; ===============================
    strResult := RegExReplace(strResult, "[`r`n]+", "`r`n") ; 多个换行符号替换为一个换行符号
    strResult := RegExReplace(strResult, "(?<=？)[`r`n]+(?=为什么？)", "") ; 删除"？\r\n为什么？"中间的换行符号，因为主观题的问题中常常需要先问结论，再问理由，例如：“是否构成犯罪？为什么？”，前一个“？”后加换行不合理。
    strResult := Trim(strResult, "`r`n`t 　")
    ; strResult := RegExReplace(strResult, "[\p{Han}]$", "$0。")
    return strResult
}

BreakParagraphByHyphen(string)
{
    strResult := string
    ; 将长句按照-或冒号分成两个短的句子。
    strResult := RegExReplace(strResult, "([-—:：]+)[`r`n 　]*", "`r`n")
    strResult := Trim(strResult, "`r`n`t 　")
    return strResult
}
Prefix(string)
{
    strResult := string
    strResult := RegExReplace(strResult, "^([反范]?例|[又再比譬例]?如)[,，:：`r`n]*", "$1`r`n")
    strResult := RegExReplace(strResult, "[`r`n]*(([仅只既还也又亦]|不[仅只]?|一般不?|主要)?(包括|包?含|具有|限于|可[以能][是为]?|(?<![许认])可(?![诉靠])))[,，:：`r`n]?", "`r`n$1`r`n")
    return strResult
}
Suffix(string)
{
    strResult := string
    strResult := RegExReplace(strResult, "[`r`n]*(?<!([高中低上下相不平对]|((?<!合)同)))等+([\p{Han}]*)[,.，。！]?$", "`r`n等$1")
    return strResult
}
BreakParagraphByChineseComma(string)
{
    strResult := string
    ; 将长句按照顿号或逗号分成短的词语。
    strResult := RegExReplace(strResult, "[`s`r`n]*((?:[、，：；､,:;／]|或者?|抑或)+|及其(?![他它])|以及|并?且|(?<![一合兼吞])并(?![购用存列行发入排联轨网架集案网拢论]))[`s`r`n]*", "`r`n")
    strResult := RegExReplace(strResult, "(?(?<=[共联])(和(?!国))|和(?!(解(?![除释]))|约(?!定)]))", "`r`n")
    strResult := RegExReplace(strResult, "(?<![涉以普不提及触顾遍危波未所未惠企殃累又])及(?![时早格至第期])", "`r`n")
    strResult := RegExReplace(strResult, "\s*(?(?<=\d)\/(?!\d)|\/)\s*", "`r`n") ; 避免在这样的分数“2/3”中的/处分割字符串
    strResult := RegExReplace(strResult, "(?<=”)(?=“)", "`r`n") ; 两个引号包括的词在引号处换行，例如“张三”“李四”，在‘”I“’，在光标“I”处插入换行。
    strResult := RegExReplace(strResult, "[`r`n]+", "`r`n") ; 多个换行符号替换为一个换行符号
    strResult := Trim(strResult, "`s`r`n`t 　､,;:｡、，；：。")
    strResult := Prefix(strResult)
    strResult := Suffix(strResult)
    return strResult
}
BreakParagraphToItems(string)
{
    strResult := string
    ; 将长句按照顿号或逗号分成短的词语。
    ; strResult := RegExReplace(strResult, "[`s`r`n]*([，；]?(?:或者?|抑或)|[:：、､，,／或]+|及其(?![他它])|以及)+[`s`r`n]*", "`r`n")
    strResult := RegExReplace(strResult, "[`s`r`n]*((?:[、，：；､,:;／]|或者?|抑或)+|及其(?![他它])|以及|[并且]{1，2})[`s`r`n]*", "`r`n")
    strResult := RegExReplace(strResult, "(?<![让参给赠])与", "`r`n")
    strResult := RegExReplace(strResult, "(?<![涉不普遍延])及(?![时于])", "`r`n")
    strResult := RegExReplace(strResult, "(?(?<=[共联])(和(?!国))|和(?!(解(?!除))|约(?!定)]))", "`r`n")
    strResult := RegExReplace(strResult, "\s*(?(?<=\d)\/(?!\d)|\/)\s*", "`r`n") ; 避免在这样的分数“2/3”中的/处分割字符串
    strResult := RegExReplace(strResult, "[`r`n]+", "`r`n") ; 多个换行符号替换为一个换行符号
    strResult := Trim(strResult, "`s`r`n`t 　､,;:｡、，；：。")
    strResult := Prefix(strResult)
    strResult := Suffix(strResult)
    return strResult
}
BreakParagraphByComma(string)
{
    strResult := string
    strResult := Trim(strResult, "`r`n`t 　")
    strResult := RTrim(strResult, "-_—、，；。`r`n`t 　") . "。"
    ; 将长句按照逗号分成短的词语。
    strResult := RegExReplace(strResult, "([，,:：；;。?？!！]+)[`r`n`t 　]*", "$1`r`n")
    ; strResult := Prefix(strResult)
    strResult := Suffix(strResult)
    return strResult
}
BreakParagraphBySemicolon(string)
{
    strResult := string
    strResult := Trim(strResult, "`r`n`t 　")
    strResult := RTrim(strResult, "-_—、，；。`r`n`t 　") . "。"
    ; 将长句按照逗号分成短的词语。
    strResult := RegExReplace(strResult, "([:：；;。?？!！]+)[`r`n`t 　]*", "$1`r`n")
    ; strResult := Prefix(strResult)
    strResult := Suffix(strResult)
    return strResult
}
TrimPrefixAndSuffix(string)
{
    ; 此函数的目的是移除包裹字符串的括号、字符串行首的序号、行尾的标点
    strResult := string
    strResult := RegExReplace(strResult, "^[\[［「『〖【〔﹝❲⦗(（]+([^\[［「『〖【〔﹝❲⦗(（\]］」』〗】〕﹞❳⦘)）]+)[\]］」』〗】〕﹞❳⦘)）]+$", "$1") ; 移除两端成对的括号
    strResult := RegExReplace(strResult, "mi)^\s*(?:\d+|[a-z])[\.､,、，]\s*(.+)", "$1") ; 移除所有行首序号及对应的分隔符，如“1. ”、“B、”
    strResult := RegExReplace(strResult, "m)\s*[､,;:｡、，；：。]+\s*$",  "") ; 移除所有行尾标点。
    strResult := Trim(strResult, "❗️‼️") ; 移除首尾的着重号标记。
    strResult := LTrim(strResult, "’”]］」』〗】〕﹞❳⦘)）｝》〉＞ 　`r`n") ; 移除行首明显错误的不配对的右标点
    strResult := RTrim(strResult, "‘“[［「『〖【〔﹝❲⦗(（｛《〈＜ 　`r`n") ; 移除行尾明显错误的不配对的左标点
    ; 移除行首不明显不配对的左标点, 如果一个左标点出现在行首，且不成对，则将其移除
    While (InStr("“‘（【《〈([", SubStr(strResult, 1, 1)) and not RegExMatch(strResult, "^(?<pair>“(?:[^“”]|(?R))*”|‘(?:[^‘’]|(?R))*’|（(?:[^（）]|(?R))*）|【(?:[^【】]|(?R))*】|《(?:[^《》]|(?R))*》|〈(?:[^〈〉]|(?R))*〉|\((?:[^()]|(?R))*\)|\[(?:[^\[\]]|(?R))*\]|\{(?:[^\{\}]|(?R))*\})"))
    {
        strResult := SubStr(strResult, 2) ; 去除字符串头部不配对的左标点
    }
    ; 移除行尾不明显不配对的右标点, 如果一个右标点出现在行尾，且不成对，则将其移除
    While (InStr("”’）】》〉)]", SubStr(strResult, -1, 1)) and not RegExMatch(strResult, "(?<pair>“(?:[^“”]|(?R))*”|‘(?:[^‘’]|(?R))*’|（(?:[^（）]|(?R))*）|【(?:[^【】]|(?R))*】|《(?:[^《》]|(?R))*》|〈(?:[^〈〉]|(?R))*〉|\((?:[^()]|(?R))*\)|\[(?:[^\[\]]|(?R))*\]|\{(?:[^\{\}]|(?R))*\})$" ))
    {
        strResult := SubStr(strResult, 1, -1) ; 去除字符串尾部不配对的右标点
    }
    return strResult
}
LintChinese(string)
; 此脚本的目的是去除剪贴板中的字符串中多余的换行符号, 以及一些常见的格式错误。
{
; region SignDefinitions
    ; 英文标点
    PUNCTUATION_EN := '[,:;.?!-]'

    ; 中文标点符号
    PUNCTUATION_CN := '[‘’“”、。《》〈〉『』！＂＇（），／：；＜＝＞？［］｛｝]'

    ; 汉字
    CHARS_CN := '[\p{Han}]'

    ; 数字
    DIGIT := '[0-9]'

    ; 圆圈数字
    CIRCLEDDIGIT := '[①②③④⑤⑥⑦⑧⑨⑩⑪⑫⑬⑭⑮⑯⑰⑱⑲⑳㉑㉒㉓㉔㉕㉖㉗㉘㉙㉚㉛㉜㉝㉞㉟㊱㊲㊳㊴㊵㊶㊷㊸㊹㊺㊻㊼㊽㊾㊿]'

    ; 与汉字应留空格的特殊符号
    MathSign := '[-+*/=%‰‱^&#<>＋－＜＝＞±×÷∈∏∑∕√∝∞∟∠∣∥∧∨∩∪∫∮∴∵∶∷∽≈≌≒≠≡≤≥≦≧≮≯⊕⊙⊥⊿~→↑←↓↖↗↘↔↕↰↱↲↳↴↵↶↷↼↽↾↿⇀⇁⇂⇃↹↺↻⇄⇅⇆⇇⇈⇉⇊⇋⇌⇍⇎⇏⇐⇑⇒⇓⇔⇕⇖⇗⇘⇙⇚⇛⇜⇝⇞⇟⇠⇡⇢⇣⇤⇥⇦⇧⇨⇩⇪•]'

    ; 全角数字
    DIGIT_CN := '[\x{ff10}-\x{ff19}]'

    ; 英文字母
    CHARS_EN := '[a-zA-Z]'

    ; 英文字母或数字
    CHARS_EN_OR_DIGIT := '[a-zA-Z0-9]'

    ; 与前导数字间应留空格的单位
    ; TODO: 需要添加更多的单位，单位见以下链接
    ; http://unicode-table.com/cn/blocks/cjk-compatibility/
    ; http://unicode-table.com/cn/#2031
    ; http://unicode-table.com/cn/#2100
    UNIT_SYMBOL := '[\x{3371}-\x{337A}\x{3380}-\x{33df}\x{2100}-\x{2109}]'
    ; 空白符号，注意不只是空格，还包括换行符号
    BLANK := '[\s\x{2000}-\x{200A}\x{3000}]'
    ; 空格
    SPACE := '[\x{2000}-\x{200A}\x{3000} `t]'
    ; 换行
    LINEBREAK := '[`r`n]'
; endregion SignDefinitions

    strResult := string

; region 全角转半角
    ; 部分全角符号已经不是规范的使用方法，故意将其替换为半角符号
    FULLWIDTH_CHARS := "ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ０１２３４５６７８９＃＄％＆（）＊＋－．／＼＜＝＞［］＾＿｝｜｛～〜＠　＇"
    HALFWIDTH_CHARS := "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789#$%&()*+-./＼<=>[]^_}|{~~@ '"
    Loop StrLen(FULLWIDTH_CHARS) {
        strResult := StrReplace(strResult, SubStr(FULLWIDTH_CHARS, A_Index, 1), SubStr(HALFWIDTH_CHARS, A_Index, 1))
    }
; endregion 全角转半角

   ERRORS := Map(
        'E001' , [
                    ["汉字前的半角逗号替换为全角逗号" , Format("{1}+{2}*(?={3})" , "," , SPACE, CHARS_CN) , "，"] ,
                    ["汉字前的半角分号替换为全角分号" , Format("{1}+{2}*(?={3})" , ";" , SPACE, CHARS_CN) , "；"] ,
                    ["汉字前的半角冒号替换为全角冒号" , Format("{1}+{2}*(?={3})" , ":" , SPACE, CHARS_CN) , "："] ,
                    ["汉字前的比号“∶”替换为全角冒号" , Format("{1}+{2}*(?={3})" , "∶" , SPACE, CHARS_CN) , "："] ,
        ],
        'E002' , [
                    ["汉字后的半角顿号替换为全角顿号" , Format("(?<={3}){2}*{1}+" , "､"  , SPACE , CHARS_CN) , "、"] ,
                    ["汉字后的半角逗号替换为全角逗号" , Format("(?<={3}){2}*{1}+" , ","  , SPACE , CHARS_CN) , "，"] ,
                    ["汉字后的半角分号替换为全角分号" , Format("(?<={3}){2}*{1}+" , ";"  , SPACE , CHARS_CN) , "；"] ,
                    ["汉字后的半角冒号替换为全角冒号" , Format("(?<={3}){2}*{1}+" , ":"  , SPACE , CHARS_CN) , "："] ,
                    ["汉字后的半角句号替换为全角句号" , Format("(?<={3}){2}*{1}+" , "\." , SPACE , CHARS_CN) , "。"] ,
                    ["汉字后的半角问号替换为全角问号" , Format("(?<={3}){2}*{1}+" , "\?" , SPACE , CHARS_CN) , "？"] ,
                    ["汉字后的半角叹号替换为全角叹号" , Format("(?<={3}){2}*{1}+" , "!"  , SPACE , CHARS_CN) , "！"] ,
                    ["汉字后的比号“∶”替换为全解冒号" , Format("(?<={3}){2}*{1}+" , "∶"  , SPACE , CHARS_CN) , "："] ,
        ],
        'E030' , [
                    ["英文间的全角顿号替换为半角顿号" , Format("(?<={3}){2}*{1}+{2}*(?={3})" , "、" , SPACE, CHARS_EN) , "､ "] ,
                    ["英文间的全角逗号替换为半角逗号" , Format("(?<={3}){2}*{1}+{2}*(?={3})" , "，" , SPACE, CHARS_EN) , ", "] ,
                    ["英文间的全角分号替换为半角分号" , Format("(?<={3}){2}*{1}+{2}*(?={3})" , "；" , SPACE, CHARS_EN) , "; "] ,
                    ["英文间的全角冒号替换为半角冒号" , Format("(?<={3}){2}*{1}+{2}*(?={3})" , "：" , SPACE, CHARS_EN) , ": "] ,
                    ["英文间的全角句号替换为半角句号" , Format("(?<={3}){2}*{1}+{2}*(?={3})" , "。" , SPACE, CHARS_EN) , ". "] ,
        ],
        'E040' , [
                    ["数字间的全角顿号替换为半角顿号" , Format("(?<={3}){2}*{1}+{2}*(?={3})" , "、" , SPACE, DIGIT) , "､ "] ,
                    ["数字间的全角逗号替换为半角逗号" , Format("(?<={3}){2}*{1}+{2}*(?={3})" , "，" , SPACE, DIGIT) , ", "] ,
                    ["数字间的全角分号替换为半角分号" , Format("(?<={3}){2}*{1}+{2}*(?={3})" , "；" , SPACE, DIGIT) , "; "] ,
                    ["数字间的全角冒号替换为半角冒号" , Format("(?<={3}){2}*{1}+{2}*(?={3})" , "：" , SPACE, DIGIT) , ":"]  , ; 两个数字之间的冒号表示时间（15:30）或比例（1:2:3:4）, 可以不留空格。
                    ["数字间的比号“∶”替换为半角冒号" , Format("(?<={3}){2}*{1}+{2}*(?={3})" , "∶" , SPACE, DIGIT) , ":"]  , ; 比号“∶”并不是常见的符号，使用常见的半角冒号代替
                  ; ["数字间的全角句号替换为半角句号" , Format("(?<={3}){2}*{1}+{2}*(?={3})" , "。" , SPACE, DIGIT) , ". "] ,
        ],
        'E003' , [
                  ; ["汉字两边的半角圆括号替换为全角圆括号"       , Format("[（\(]([^（）\(\)]*{1}+[^（）\(\)]*)[）\)]", CHARS_CN)       , "（$1）"] ,
                  ; ["汉字两边的半角圆括号替换为全角圆括号"       , Format("[(（]((?:[^()（）]*{1}+[^()（）]*|((?R)))+)[)）]", CHARS_CN) , "（$1）"] , ; 此行代码错误，当括号间有换行时会出错
                  ; ["汉字两边的半角圆括号替换为全角圆括号"       , "[(（]((?:[^()（）\p{Han}]*[\p{Han}][^()（）\p{Han}]*|((?R)))+)[)）]", "（$1）"] , ; 此行代码在括号有嵌套时内层括号无法转为全角，故而放在循环外处理
                    ["汉字两边的半角和全角方括号替换为中文方括号" , Format("[\[［「『〖【〔﹝❲⦗]([^\[［「『〖【〔﹝❲⦗\]］」』〗】〕﹞❳⦘]*{1}+[^\[［「『〖【〔﹝❲⦗\]］」』〗】〕﹞❳⦘]*)[\]］」』〗】〕﹞❳⦘]", CHARS_CN) , "【$1】"] ,
                    ["汉字两边的半角引号替换为全角引号"           , Format("[`"“]([^`"“”]*{1}[^`"“”]*)[`"”]", CHARS_CN)                  , "“$1”"]   ,
                    ["英文、数字两边的全角圆括号替换为半角圆括号" , Format("[（\(]({1}+)[）\)]", "[-0-9a-zA-Z,\.!?'; ]")                  , "($1)"]   ,
                    ["英文、数字两边的全角引号替换为半角引号"     , Format("[`"“]({1}+)[`"”]", "[-0-9a-zA-Z,\.!?'; ]")                    , '"$1"']   ,
        ],
        'E004' , [
                    ["全角右标点后的半角顿号替换为全角顿号" , Format("(?<={3}){2}*{1}+" , "､"  , SPACE , "[’”）》〉】]") , "、"] ,
                    ["全角右标点后的半角逗号替换为全角逗号" , Format("(?<={3}){2}*{1}+" , ","  , SPACE , "[’”）》〉】]") , "，"] ,
                    ["全角右标点后的半角分号替换为全角分号" , Format("(?<={3}){2}*{1}+" , ";"  , SPACE , "[’”）》〉】]") , "；"] ,
                    ["全角右标点后的半角冒号替换为全角冒号" , Format("(?<={3}){2}*{1}+" , ":"  , SPACE , "[’”）》〉】]") , "："] ,
                    ["全角右标点后的半角句号替换为全角句号" , Format("(?<={3}){2}*{1}+" , "\." , SPACE , "[’”）》〉】]") , "。"] ,
                    ["全角右标点后的半角问号替换为全角问号" , Format("(?<={3}){2}*{1}+" , "\?" , SPACE , "[’”）》〉】]") , "？"] ,
                    ["全角右标点后的半角叹号替换为全角叹号" , Format("(?<={3}){2}*{1}+" , "!"  , SPACE , "[’”）》〉】]") , "！"] ,
        ],
        'E005' , [
                    ["删除中文标点前的空格"       , Format('{1}+(?={3})'          , SPACE , PUNCTUATION_EN , PUNCTUATION_CN) , ""]  ,
                    ["删除中文标点后的空格"       , Format("(?<={3}){1}+"         , SPACE , PUNCTUATION_EN , PUNCTUATION_CN) , ""]  ,
                    ["删除英文标点前的空格"       , Format("{1}+(?={2})"          , SPACE , PUNCTUATION_EN , PUNCTUATION_CN) , ""]  ,
                    ["英文标点后的空格修正为一个" , Format("(?<={3}{2}){1}*(?!$)" , SPACE , PUNCTUATION_EN , CHARS_EN)       , " "] ,
        ],
        'E006' , [
                    ["删除行首的空白"         , Format("m)^{1}+"                                                               , BLANK) , ""]   ,
                    ["删除行尾的空白"         , Format("m){1}+$"                                                               , BLANK) , ""]   ,
                    ["删除左括号右侧的空白"   , Format("(?<=[\[［「『〖【〔﹝❲⦗《〈（\({]){1}+"                                  , BLANK) , ""]   ,
                    ["删除右括号左侧的空白"   , Format("{1}+(?=[\]］」』〗】〕﹞❳⦘》〉）\)}])"                                   , BLANK) , ""]   ,
                    ["删除全角括号两侧的空白" , Format("{1}*([［「『〖【〔﹝《〈（］」』〗】〕﹞》〉）]){1}*(?![ABCD][\. `r`n\s])" , SPACE) , "$1"] , ; 正则尾部增加 (?![ABCD][\. `r`n])  的目的是为了避免正则去除形如“（2019 金题 - 1 - 13，多）”的右括号后的换行 , 也即，避免不合适的将选择题的选项与选择题的问题或上一个选项拼接在一起。
        ],
        'E007' , [
                    ["删除汉字之间的空格"               , Format("(?<={5}){1}+(?={5})" , SPACE , MathSign , DIGIT , CHARS_EN , CHARS_CN) , "" ] ,
                    ; 虽然已经有语句用于删除中文标点（包括括号）前的空格，但是为了能够统一将汉字外侧的括号改为全角，其余的括号改为半角，会有一个统一将括号替换为半角的操作，因而全角括号前的空格不容易删除，故在此处明确的删除汉字与括号间的空格
                    ["删除汉字与括号之间的空格"          , Format("(?<={5}){1}+(?={2})" , SPACE , '[()（）]' , DIGIT , CHARS_EN , CHARS_CN) , "" ] ,
                    ["删除括号与汉字之间的空格"          , Format("(?<={2}){1}+(?={5})" , SPACE , '[()（）]' , DIGIT , CHARS_EN , CHARS_CN) , "" ] ,
                    ["英文单词间与汉字间的空格修正为一个" , Format("(?<={4}){1}*(?={5})" , SPACE , MathSign , DIGIT , CHARS_EN , CHARS_CN) , " "] ,
                    ["汉字与英文单词之间的空格修正为一个" , Format("(?<={5}){1}*(?={4})" , SPACE , MathSign , DIGIT , CHARS_EN , CHARS_CN) , " "] ,
        ],
        'E008' , [
                    ["删除汉字之间的圆圈数字"           , Format("(?<={5}){6}+(?={5})" , SPACE         , MathSign , DIGIT , CHARS_EN , CHARS_CN , CIRCLEDDIGIT , PUNCTUATION_CN) , "" ] ,
                    ["删除汉字与标点之间的圆圈数字"     , Format("(?<={5}){6}+(?={7})" , SPACE         , MathSign , DIGIT , CHARS_EN , CHARS_CN , CiRCLEDDIGIT , PUNCTUATION_CN) , "" ] ,
                    ["删除英文单词与空格之间的圆圈数字" , Format("(?<={4}){6}+(?={1})" , SPACE         , MathSign , DIGIT , CHARS_EN , CHARS_CN , CiRCLEDDIGIT , PUNCTUATION_EN) , "" ] ,
                    ["删除英文单词与标点之间的圆圈数字" , Format("(?<={4}){6}+(?={7})" , SPACE         , MathSign , DIGIT , CHARS_EN , CHARS_CN , CiRCLEDDIGIT , PUNCTUATION_EN) , "" ] ,
                    ["删除行尾的圆圈数字"               , Format("m){1}$"              , CIRCLEDDIGIT) , ""]      ,
        ],
        'E020' , [
                    ; 通常情况下这种方法是正确的，但是选择题中的每一条选项的结尾常常没有标点，此时将多行拼接起来并不合适
                    ; ["删除汉字后的换行"       , Format("(?<={2}){1}+" , LINEBREAK, CHARS_CN)      , ""],
                    ; 若下一行以“A.”（A表示字母或数字）结构开头，则不拼接，方便复制选择题的选项
                    ["删除汉字与汉字或标点之间的换行"   , Format("(?<={2}){1}+(?={3})" , LINEBREAK, CHARS_CN, "[\p{Han}､,;:｡!?、，；：。！？]"), ""],
                    ["删除汉字与数字金额之间的换行"     , Format("(?<={2}){1}+{3}" , LINEBREAK, CHARS_CN, "(\s*\d+\s*[万亿]*[元股])"), "$1"],
                    ["删除汉字'年'与数字月份之间的换行" , Format("(?<={2}){1}+{3}" , LINEBREAK, "年", "(\s*\d{1,2}\s*月份?)"), "$1"],
                    ["删除汉字'月'与数字日期之间的换行" , Format("(?<={2}){1}+{3}" , LINEBREAK, "月", "(\s*\d{1,2}\s*[日号])"), "$1"],
                    ["删除汉字'日期或日期段'与数字时辰之间的换行" , Format("(?<={2}){1}+{3}" , LINEBREAK, "[日号]|早上|上午|中午|下午|晚上|半夜|零辰|用时", "(\s*\d{1,2}\s*([时点]|小时))"), "$1"],
                    ["删除汉字'[时点]|小时'与数字分钟之间的换行" , Format("(?<={2}){1}+{3}" , LINEBREAK, "[时点]|小时", "(\s*\d{1,2}\s*分钟?)"), "$1"],
                    ["删除汉语'分钟'与数字秒之间的换行" , Format("(?<={2}){1}+{3}" , LINEBREAK, "分钟", "(\s*\d{1,2}\s*秒)"), "$1"],
                    ["删除汉字'分'与数字秒之间的换行" , Format("(?<={2}){1}+{3}" , LINEBREAK, "分", "(\s*\d{1,2}\s*秒)"), "$1"],
                    ["删除汉字'第'与数字序号之间的换行" , Format("(?<={2}){1}+{3}" , LINEBREAK, "第", "(\s*\d+)"), "$1"],
                    ["替换字母或数字后的换行为空格"     , Format("(?<={2}){1}+(?!$)" , LINEBREAK, CHARS_EN_OR_DIGIT)      , " "],
                    ["删除顿号后的换行"                 , Format("(?<={2}){1}+" , LINEBREAK, "、")         , ""],
                    ["删除逗号后的换行"                 , Format("(?<={2}){1}+",  LINEBREAK, "[,，]")      , ""],
                    ; 法条中有多个条款时，除最后一条外，常常以分号结尾，不适合合并成一行
                    ; ["删除分号后的换行"       , Format("(?<={2}){1}+" , LINEBREAK, "[; ；]")      , ""],
                    ["删除多余的换行"               , Format("{1}+" , LINEBREAK) , "`r`n"],
        ],
        'E021' , [
                    ["数字与数字之间的多个空格修正为一个"     , Format("(?<={3}){1}+(?={3})"      , SPACE , MathSign , DIGIT , CHARS_EN , CHARS_CN) , " "] ,
                    ["数字与汉字之间的空格修正为一个"         , Format("(?<={3}){1}*(?={5})"      , SPACE , MathSign , DIGIT , CHARS_EN , CHARS_CN) , " "] ,
                    ["汉字与数字之间的空格修正为一个"         , Format("(?<={5}){1}*(?={3})"      , SPACE , MathSign , DIGIT , CHARS_EN , CHARS_CN) , " "] ,
                    ["数字与英文单词之间的空格修正为一个"     , Format("(?<={3}){1}*(?={4})"      , SPACE , MathSign , DIGIT , CHARS_EN , CHARS_CN) , " "] ,
                    ["英文单词与数字之间的空格修正为一个"     , Format("(?<={4}){1}*(?={3})"      , SPACE , MathSign , DIGIT , CHARS_EN , CHARS_CN) , " "] ,
                    ["删除英文单词间多余的空格"               , Format("(?<={4}){1}+(?={4})"      , SPACE , MathSign , DIGIT , CHARS_EN , CHARS_CN) , " "] ,
                    ["数学符号与汉字之间的空格修正为一个"     , Format("(?<={2}){1}*(?={5})"      , SPACE , MathSign , DIGIT , CHARS_EN , CHARS_CN) , " "] ,
                    ["汉字与数学符号之间的空格修正为一个"     , Format("(?<={5}){1}*(?={2})"      , SPACE , MathSign , DIGIT , CHARS_EN , CHARS_CN) , " "] ,
                    ["数学符号与英文单词之间的空格修正为一个" , Format("(?<={2}){1}*(?={4})"      , SPACE , MathSign , DIGIT , CHARS_EN , CHARS_CN) , " "] ,
                    ["英文单词与数学符号之间的空格修正为一个" , Format("(?<={4}){1}*(?={2})"      , SPACE , MathSign , DIGIT , CHARS_EN , CHARS_CN) , " "] ,
                    ["数学符号与数字之间的空格修正为一个"     , Format("(?<={2}){1}*(?={3})"      , SPACE , MathSign , DIGIT , CHARS_EN , CHARS_CN) , " "] ,
                    ["数字与数学符号之间的空格修正为一个"     , Format("(?<={3}){1}*(?={2})"      , SPACE , MathSign , DIGIT , CHARS_EN , CHARS_CN) , " "] ,
                    ["数字与单位符号之间的空格修正为一个"     , Format("(?<={3}){1}*(?={2})"      , SPACE , UNIT_SYMBOL , DIGIT , CHARS_EN , CHARS_CN) , " "] ,
                    ; ↓数学符号中的分数线"/"两侧与数字间不留空格
                    ["分数线两侧与数字间不留空格"             , Format("(?<={3}){1}*/{1}*(?={3})" , SPACE , MathSign , DIGIT , CHARS_EN , CHARS_CN) , "/"] ,
                    ; ↓数学符号中的百分号“%”、千分号“‰”、万分号“‱”左侧与数字间不留空格
                    ["数字与百分号、千分号、万分号间不留空格" , Format("(?<={3}){1}*(?=[%‰‱])"    , SPACE , MathSign , DIGIT , CHARS_EN , CHARS_CN) , ""]  ,
                    ; ↓数学符号中的百分号“%”、千分号“‰”、万分号“‱”右侧与数学符号间留一个空格
                    ["百分号、千分号、万分号与数学符号之间的空格修改为一个" , Format("(?<=[%‰‱])(?={2})" , SPACE , MathSign , DIGIT , CHARS_EN , CHARS_CN) , " "]  ,
        ],
    )

    for code, errorList in ERRORS
    {
        for i in errorList
        {
            try {
                strResult := RegExReplace(strResult, i[2], i[3])
                ; msgbox(strResult, i[1])
            } catch Error as err{
                msgbox("将“ " . i[1] . " ”时发生错误！")
                throw err
            }
        }
    }
    ; 例外处理
    ; 以上代码在将包括汉字的括号转为全角括号时，如果括号有嵌套的情况则不能很好的工作，因而放在此处使用递归函数处理
    strResult := NormalizeBrackets(strResult)
    ; 上面的代码只会将英文后的标点简单的替换为半角，但是一个句子中只有最后一个符号是英文字母，则这个英文字母后的标点也会被替换为半角标点符号，该标点符号看起来就会比较奇怪，因此用以下这个函数修正这一错误。
    strResult := CorrectHalfWidthPunctuationAtSentenceEnd(strResult)
    ;While (RegExMatch(strResult, Format("{3}({1}{2}+{3}){2,}", ":", SPACE, DIGIT), &Match))
    ;{
    ;    ; 两个数字之间的冒号表示时间（15:30)或比例（1:2:3:4), 可以不留空格。ERRORS中的正则可以不给冒号号留空。
    ;    ; 尚未想到什么样的语境下数字间的冒号表示冒号本身的含义，未来如果遇到, 可在ERRORS中的正则中给冒号后正常添加空格，而将此段代码反注释，此段代码可以更好的识别表示比例的“1:2:3:4”（3个数字2个冒号以上）
    ;    strResult := RegexReplace(strResult, Match.0, StrReplace(Match.0, " ", ""), , 1, Match.Pos)
    ;}
    strResult := RegExReplace(strResult, "i)4 S 店", "4S 店")
    return strResult
}
IndexOf(var, Arr, fromIndex := 1)
{
    for value in Arr
    {
        if (A_Index < fromIndex)
        {
            Continue
        }
        else if (value = var)
        {
            return A_Index
        }
	}
	return 0
}
Filt(Arr, lst)
{
    result := []
    for item in Arr
    {
        if (IndexOf(item, lst) == 0)
        {
            result.push(item)
        }
    }
    return result
}
; 此递归函数能够将多层嵌套的包裹汉字的圆括号替换为全角形式，有多层嵌套结构时，只能用递归函数实现而不能用一个简单的正则替换实现。
NormalizeBrackets(strResult)
{
    ; 只匹配横向空白，不匹配 `r / `n，避免把选择题选项行错误拼接到上一行。
    HSPACE := "[\x{2000}-\x{200A}\x{3000} `t]"

    ; 在原来的括号匹配规则外侧增加 HSPACE*。
    ; 这样将含汉字的半角括号恢复为全角括号时，会同时删除括号外侧的横向空白。
    pattern := HSPACE "*[(（](?<stringContainsHanInBracket>(?:[^()（）\p{Han}]*[\p{Han}][^()（）\p{Han}]*|(?R))+)[)）]" HSPACE "*"

    pos := 1
    while (pos := RegExMatch(strResult, pattern, &Match, pos)) {
        prefix := SubStr(strResult, 1, Match.Pos - 1)
        suffix := SubStr(strResult, Match.Pos + Match.Len)

        infix := NormalizeBrackets(Match.stringContainsHanInBracket)
        newPair := "（" . infix . "）"

        strResult := prefix . newPair . suffix

        ; 不建议继续使用 pos += StrLen(Match.0)
        ; 因为 Match.0 包含了被删除的外侧空白，替换后长度会变化。
        ; 用替换后新括号的末尾位置继续搜索更稳。
        pos := StrLen(prefix) + StrLen(newPair) + 1
    }

    return strResult
}
; 初始化数字映射
global CN_NUM_MAP := Map(
    '〇', '0', '一', '1', '二', '2', '三', '3', '四', '4', '五', '5', '六', '6', '七', '7', '八', '8', '九', '9'
)

; 初始化单位映射
global CN_UNIT_MAP := Map(
    '十', 1, '百', 2, '千', 3, '万', 4, '亿', 8
)

global CN_UPPER2LOWER_MAP := Map(
    '零', '〇', '壹', '一', '贰', '二', '叁', '三', '肆', '四', '伍', '五', '陆', '六', '柒', '七', '捌', '八', '玖', '九',
    '拾', '十', '佰', '百', '仟', '千', '萬', '万', '億', '亿',
    '貮', '二', '两', '二', '點', '点'
)

; 转换中文数字为阿拉伯数字的主函数
ConvertChineseNumber2Digits(zhNum) {
    ; 定义中文数字的正则表达式模式
    ZhNumPattern := "([〇一二三四五六七八九零壹贰叁肆伍陆柒捌玖十拾百佰千仟万萬亿億两]+|[〇一二三四五六七八九零壹贰叁肆伍陆柒捌玖]+)([点點][〇一二三四五六七八九零壹贰叁肆伍陆柒捌玖]+)?"

    ; 检查中文数字是否匹配模式
    if !RegExMatch(zhNum, ZhNumPattern) {
        Throw "Invalid Zh Number: " . zhNum
    }

    ; 将所有大写中文数字转换为小写
    For key, value in CN_UPPER2LOWER_MAP {
        zhNum := StrReplace(zhNum, key, value)
    }

    ; 分割整数和小数部分
    zhNumArray := StrSplit(zhNum, '点', "", 2)
    integerPart := zhNumArray[1]
    decimalPart := zhNumArray.Length > 1 ? zhNumArray[2] : ""

    ; 转换整数部分
    if RegExMatch(integerPart, "[亿万千百十]") {
        ; 处理包含单位的数字
        integerPart := RegExReplace(integerPart, "(^|[亿万千百〇])\K(?=十)", "一")
        integerResult := ConvertChineseInteger2Digits(integerPart)
    } else {
        ; 直接转换纯数字部分
        integerResult := ""
        Loop Parse, integerPart {
            integerResult .= CN_NUM_MAP[A_LoopField]
        }
    }

    ; 转换小数部分
    if (decimalPart = "") {
        return integerResult
    } else {
        decimalResult := ""
        For index, char in StrSplit(decimalPart, "") {
            decimalResult .= CN_NUM_MAP[char]
        }
        return integerResult . "." . decimalResult
    }
}

; 使用递归方式实现的整数部分转换函数
ConvertChineseInteger2Digits(ChineseInteger) {
    if (ChineseInteger = "")
        return "0"

    ; 检查是否存在单位（亿或万），并递归处理
    For index, unit in ["亿", "万"] {
        pos := InStr(ChineseInteger, unit,,,-1)
        if (pos > 0) {
            leftPart := SubStr(ChineseInteger, 1, pos - 1)
            rightPart := SubStr(ChineseInteger, pos + StrLen(unit))
            leftNum := ConvertChineseInteger2Digits(leftPart)
            rightNum := ConvertChineseInteger2Digits(rightPart)
            return leftNum . Format("{:0" . CN_UNIT_MAP[unit] . "s}", rightNum)
        }
    }

    resultArray := ["0", "0", "0", "0"]
    unitLevel := 0
    currentChar := ""

    Loop StrLen(ChineseInteger) {
        currentChar := SubStr(ChineseInteger, -A_Index, 1)
        if (CN_NUM_MAP.Has(currentChar)) {
            ; 如果是数字字符，则根据unitLevel确定其在结果中的索引位置
            if (currentChar != "〇") {
                resultArray[4 - unitLevel] := CN_NUM_MAP[currentChar]
            }
        } else if (CN_UNIT_MAP.Has(currentChar)) {
            ; 如果是单位字符，则更新unitLevel
            unitLevel := CN_UNIT_MAP[currentChar]
        }
    }
    result := JoinStrArray(resultArray)

    result := LTrim(result, '0')
    return result
}

CorrectHalfWidthPunctuationAtSentenceEnd(strResult) {
    ; 正则表达式，捕获组1是句子，捕获组2是末尾的标点
    ; regex := "(?<=^|[、，：；。？！“”､,:;.｡?!`"])([ a-zA-Z\p{Han}]+[a-zA-Z])([､,:;.?!])"
    regex := "m)(?<=^|[、，：；。？！“”､,:;.｡?!`"\s])([^`r`n、，：；。？！“”､,:;.｡?!`"%]+[a-zA-Z])([､,:;.?!])\s*"
    ; 使用正则表达式查找匹配项并替换
    pos := 1
    while (pos := RegExMatch(strResult, regex, &match, pos)) {
        sentence := match.1
        punctuation := match.2

        ; 计算汉字和英文字母的数量
        chineseCount := StrCount(sentence, "[\p{Han}]")
        ; ↑汉字字符数量
        ; englishCount := StrLen(sentence) - chineseCount
        ; ↑非汉字字符数量
        englishWordCount := StrCount(sentence, "[-a-zA-Z]+")
        ; ↑英文单词数量

        ; 如果汉字数量多于英文字母，则将末尾的半角标点替换为全角标点
        if (chineseCount > 0 and chineseCount >= englishWordCount) {
            switch punctuation {
                case ".":
                    punctuation := "。"
                case "､":
                   punctuation := "、"
                case ",":
                    punctuation := "，"
                case ";":
                    punctuation := "；"
                case ":":
                    punctuation := "："
                case "?":
                    punctuation := "？"
                case "!":
                    punctuation := "！"
            }
        }
        sentenceWithPunctuation := sentence . punctuation
        ; 将处理后的文本拼接回去
        strResult := StrReplace(strResult, match.0, sentenceWithPunctuation)
        pos += StrLen(match.0)
    }
    return strResult
}
; 规范示例中的标签，如出现在文本开头的“范例：”字样后的"帮助犯"、出现在文本末尾的2024年第2题，统一放置在“范例：”字样后的括号内
FormatTagsOfExampleText(text) {
    text := Trim(text)
    if !RegExMatch(text, "^[范反]例：") {
        ; 如果不以“范例：”字样开头，则直接返回原字符串
        return text
    }
    static tagPattern := "s)((?<=^[范反]例：)(?<tag>（(?<cell>[^（）、，]{3,})([、，](?&cell))*）)[,，:：]?)|(?<=[。！？\r\n])(?&tag)$"

    allCells := []

    ; 提取所有括号中的内容，并拆分成 cell
    pos := 1
    while (RegExMatch(text, tagPattern, &m, pos)) {
        ; 使用正则提取括号内内容（忽略前后空格）
        if RegExMatch(m.0, "[（(]([^（）()]+)[）)]", &matchInMatch) {
            bracketContent := matchInMatch[1]
        } else {
            bracketContent := ""
        }

        ; 用 [、，] 分割 + Trim + 加入数组
        items := StrSplit(bracketContent, ["、", "，"], " ")
        for item in items {
            if (item != "") {
                allCells.Push(Trim(item))
            }
        }

        ; 删除这个括号部分
        text := StrReplace(text, m.0, "", , , 1)
        pos := m.Pos
    }

    ; 去重排序（使用你已有的 SortArray 函数）
    sorted := SortArray(allCells)

    ; 构造新头部，需要判断是否存在标签，若存在标签，则用顿号拼接多个标签并加上全角圆括号，若不存在标签，则返回空字符串
    newTags := sorted.Length ? Format("（{1}）", JoinStrArray(sorted, "、")) : ""

    ; 替换或插入新的头部
    if (RegExMatch(text, "^[范反]例："))
        text := RegExReplace(text, "(?<=^[范反]例：)，?", newTags)
    else
        text := newTags . text

    return text
}
; 定义一个函数来拼接数组中的元素为一个长字符串
JoinStrArray(array, delimiter := "") {
    result := ""
    Loop array.Length {
        result .= array[A_Index]
        if (A_Index < array.Length) {
            result .= delimiter
        }
    }
    return result
}

; 计算字符串中特定字符的数量
StrCount(string, pattern) {
    count := 0
    pos := 1
    while (pos := RegExMatch(string, pattern, &m, pos)) {
        count++
        pos += StrLen(m.0)
    }
    return count
}