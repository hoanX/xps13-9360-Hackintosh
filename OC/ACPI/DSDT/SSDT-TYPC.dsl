// This SSDT fixes Type-C hot plug, and attempts to implement Thunderbolt device tree structure.

DefinitionBlock ("", "SSDT", 2, "hack", "TYPC", 0x00000000)
{
	External (_SB.PCI0.RP01.PXSX, DeviceObj)    // (from opcode)

	// USB-C
	Scope (_SB.PCI0.RP01.PXSX) // UPSB
	{
		// This is the key fix for machines that turn off the Type-C port, right here.
		Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
		{
            If (_OSI ("Darwin"))
            {
                Return (One)
            }
            Else
            {
                Return (Zero)
            }
        }
        
        Method (_STA, 0, NotSerialized)  // _STA: Status
		{
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }
            Else
            {
                Return (Zero)
            }
		}
     }
}
