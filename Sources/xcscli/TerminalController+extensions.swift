import TSCBasic

extension TerminalController {
    func writeLine(_ string: String, inColor: TerminalController.Color, bold: Bool) {
        write(string, inColor: inColor, bold: bold)
        write("\n")
    }
    
    func writePrefixPadded(_ string: String, length: Int, inColor: TerminalController.Color, bold: Bool) {
        let value = String(string.reversed()).padding(toLength: length, withPad: " ", startingAt: 0)
        let prefixed = String(value.reversed())
        write(prefixed, inColor: inColor, bold: bold)
    }
}
