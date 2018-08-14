# HP-Spectre-x360-Tools

## Disclaimer

This tool will turn off your fans and as result make your hardware run hotter. Use it on your own risk.

### This is 
A way to switch the fan on and off.

### This is not
A way to control the RPM of your fan directly. The laptop will control the RPM if the fan is on.

### Problems
A reboot or wake from standby will reset the table and turn the fan on. (can be solved with the Task Scheduler)

## General Information
The DSTS table provides a method to turn off/on the fan:

    	Method(FSSP, 1, NotSerialized)
			{
				If(LEqual(\_SB.PCI0.LPCB.EC0.ECOK, One))
				{
					If(LNotEqual(Arg0, Zero))
					{
						Store(Zero, \_SB.PCI0.LPCB.EC0.SFAN)
					}
					Else
					{
						Store(0x02, \_SB.PCI0.LPCB.EC0.SFAN)
					}
				}
			}
The register SFAN has the address "F4". The method shows that there a two possible states:
|FAN|SFAN |
|Off|**0x02**|
|On|**0x00**|

Off will turn off the fan completely regardless of the temperature of the CPU.
On will turn on the fan. 

Since the laptop isn't designed for passive use the CPU will get hot pretty quickly and the CPU will throttle down under sustained load.

To monitor the temperatures I recommend the tool **Core Temp** which can be found here: https://www.alcpu.com/CoreTemp/
It allows the user to create a notification once the CPU has reached a certain temperature as a reminder to turn on the fans again.

## RW Everything
With the tool RW Everything http://rweverything.com/ we can now change the register. The highlighted value to be set to 02 to turn off the fan.
![RWE](https://raw.githubusercontent.com/maisi/HP-Spectre-x360-Tools/master/Screenshot.PNG)

Using the command line interface of RWE I created the two scripts fanoff.bat and fanon.bat to change the value quickly.

A few remarks about RWE:

 - There can only be once instance at a time, if you have RWE open the scripts won't work.
 - There can be some strange side-effects when leaving RWE open in the background with the EC table open (&updating), like the reported battery level dropping to a low level and reported as not charging when a charger is connected. Both together can lead to windows switching to standby because it thinks the battery is about to run out. I think this happens when RWE and windows are trying to read the table at the same time.
