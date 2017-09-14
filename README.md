# NVSToggle
Nvidia Surround Toggle (NVSToggle) is a script that automatically toggles between <b>Nvidia Surround</b> and <b>Extended Desktop</b> mode on supported systems.

# Features
* One-click switching between Extended Desktop and Surround display modes.
* Supports portrait and landscape Surround (cfg file)
* Automatic configuration of bezel compensation (cfg file)
* Automatic re-ordering of Surround displays (cfg file)
* First-run wizard for ease-of-use.
* Minimal pop-ups while script executes.
* Currently supports Windows 8.1 and Windows 10 ONLY.
* Single-card ONLY (I don't have an SLI system to test on).

# User Variables
All configuration variables are stored in the following ini file: %programdata%\NVSToggle\NVSToggle.ini

<b>Bezel Correction Value</b><br>
The bezel correction value (in pixels). Valid settings for this option are 0 through 1024.<br>
Example: <i>BezelCorrection=128</i>

<b>Screen Order</b><br>
Re-order screens in Surround mode.<br>
Example: <i>SwapScreens=0</i>
* 0 = Nothing swapped
* 1 = Swap left and right
* 2 = Swap left and center
* 3 = Swap right and center
* 4 = Wrap left-to-right
* 5 = Wrap right-to-left

<b>Screen Orientation</b><br>
Screen orientation in Surround mode.<br>
Example: <i>Orientation=0</i>
* 0 = Landscape
* 1 = Portrait
* 2 = Inverted landscape
* 3 = Inverted portrait

<b>Surround Topology</b><br>
Sets the Surround Topology (You must select the option that corresponds to 1x3 mode on your system!)<br>
Example: <i>Topology=0</i>
* 0 = Do not modify the default setting.
* 1 = 1st option in the Topology drop-down menu
* 2 = 2nd option in the Topology drop-down menu
* 3 = 3rd option in the Topology drop-down menu
* 4 = 4th option in the Topology drop-down menu

<br>Taskbar Fix</b><br>
Attempts to apply a fix for windows maximizing behind the taskbar while in Surround mode.<br>
Example: <i>TaskbarFix=0</i>
* 0 = Fix Disabled (Default)
* 1 = Fix Enabled

<b>Show Status Window</b><br>
Displays a status window with script status during runtime.
Example: <i>ShowStatusWindow=1</i>
* 0 = Status window disabled
* 1 = Status window enabled (Default)
