// Make brightness control and brightness keys work

DefinitionBlock ("", "SSDT", 2, "hack", "BCKM", 0x00000000)
{
    External (_SB_.ACOS, IntObj)
    External (_SB_.ACSE, IntObj)
    
    // inject PNLF for Skylake to make brightness control work[1]
    Scope (_SB)
    {
        Device (PNLF)
        {
            Name (_HID, EisaId ("APP0002"))  // _HID: Hardware ID
            Name (_CID, "backlight")  // _CID: Compatible ID
            Name (_UID, 0x10)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }
    }
    
    // make BRT6 to be called on Darwin
    // call chain: _Q66 -> NEVT -> SMIE -> SMEE -> EV5 -> BRT6
    // in SMEE, EV5 is called only when OSID >= 0x20, and OSID:
    //     if ACOS == 0: init ACOS based on OS version
    //     return ACOS
    // hence set ACOS >= 0x20 can do the trick, and this trick affects less methods than _OSI renaming patch
    Scope (\)
    {
        If (_OSI ("Darwin"))
        {
            // simulate Windows 2013(Win81)
            \_SB.ACOS = 0x80
            \_SB.ACSE = Zero  //win7=0 win8=1
        }
    }
}

