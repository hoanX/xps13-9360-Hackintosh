// Fix shutdown to restart issue[1]
// Patch: Rename _PTS to ZPTS  _WAK to ZWAK
// Find: X1BUUwE=
// Replace: WlBUUwE=

DefinitionBlock ("", "SSDT", 2, "hack", "PTSWAK", 0x00000000)
{
    External (_SB_.PCI0.XHC_.PMEE, FieldUnitObj)
    External (ZPTS, MethodObj)    // 1 Arguments
    External(_SB.LID0, DeviceObj)
    External (ZWAK, MethodObj)
    
    Method (_PTS, 1, NotSerialized)  // _PTS: Prepare To Sleep
    {
        ZPTS (Arg0)
        If ((0x05 == Arg0))
        {
            \_SB.PCI0.XHC.PMEE = Zero
        }
    } 

    Method (_WAK, 1, NotSerialized)
    {   
        Local0 = ZWAK(Arg0)
        If (3 == Arg0)    
        {
           Notify (\_SB.LID0, 0x80)
        }
        Return (Local0)
    }
}