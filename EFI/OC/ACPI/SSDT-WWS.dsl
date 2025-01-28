DefinitionBlock ("", "SSDT", 2, "hack", "atk", 0x00000000)
{
    External (_SB_.ATKD, DeviceObj)
    External (_SB_.KBLV, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.ST9E, MethodObj)    // 3 Arguments
    External (_SB_.PCI0.LPCB.EC0_.WRAM, MethodObj)    // 2 Arguments

    If (_OSI ("Darwin"))
    {
        Scope (_SB.ATKD)
        {
            Method (SKBV, 1, NotSerialized)
            {
                ^^PCI0.LPCB.EC0.WRAM (0x09F0, ^^KBLV)
                ^^PCI0.LPCB.EC0.ST9E (0x1F, 0xFF, Arg0)
                Return (Arg0)
            }
        }
    }

    Device (_SB.ALS0)
    {
        Name (_HID, "ACPI0008" /* Ambient Light Sensor Device */)  // _HID: Hardware ID
        Name (_CID, "smc-als")  // _CID: Compatible ID
        Name (_ALI, 0x96)  // _ALI: Ambient Light Illuminance
        Name (_ALR, Package (0x01)  // _ALR: Ambient Light Response
        {
            Package (0x02)
            {
                0x64, 
                0x96
            }
        })
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
