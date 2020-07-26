/*
 * XCPM power management compatibility table.
 */
DefinitionBlock ("", "SSDT", 2, "ACDT", "CpuPlug", 0x00003000)
{
    External (_PR_.CPU0, ProcessorObj)

    Scope (_PR_.CPU0)
    {
        Method (_DSM, 4, NotSerialized)
        {
            If (LEqual (Arg2, Zero)) 
            {
               Return (Buffer (One) { 0x03 })
            }

            Return (Package (0x02)
            {
                "plugin-type", 
                One
            })
        }
    }
}
