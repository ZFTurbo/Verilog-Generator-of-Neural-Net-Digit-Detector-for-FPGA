# How to use project in Quartus (Method 1)

* Download Quartus from [official site](https://www.altera.com/downloads/download-center.html). We used Quartus 17.1 Lite
* Download archive of "Verilog Generator of Neural Net Digit Detector for FPGA" from GitHub
* Extract archive and navigate to "verilog/imp" folder. You can open "cam_proj.qpf" with Quartus or just double click on it (see img 1).

![Img 1](https://github.com/ZFTurbo/Verilog-Generator-of-Neural-Net-Digit-Detector-for-FPGA/blob/master/images/QV_01.png "Img 1")

* Run "Processing" -> "Start compilation". Wait while it finished
* Connect De0Nano device to USB. Make sure you have Altera USB drivers installed.
* Run "Tools" -> "Programmer". Click on "Hardware Setup" and select USB-Blaster (see img 2)

![Img 2](https://github.com/ZFTurbo/Verilog-Generator-of-Neural-Net-Digit-Detector-for-FPGA/blob/master/images/QV_02.png "Img 2")

* Push "Start" button. Sometimes it failed so push it until you see "100% Successful" in Progress field.
* After that device must work fine. Sometimes it has problem with clock synchronization, it can be fixed with "Reset button" on De0Nano.

# How to use project in Quartus (Method 2)

In first method project is loaded in energy dependent memory. So after you reconnect De0Nano it will reset to initial state. There is method to
store project in Flash memory. So after you reconnect device to any energy source it will be already initialized.

* After you compile project go to "File" -> "Convert Programming File".
* Choose Programming File Type: "JTAG Indirect Configuration File (.jic)"
* Choose "Configuration device": "EPCS16"
* Select "Flash Loader" and press "Add device..." from dialog choose "Cyclone IV E" and "EP4CE22"
* Select "SOF Data" and press "Add File...". From dialog choose "output_files/cam_proj.sof"
* And then press "Generate" (see img 3)

![Img 3](https://github.com/ZFTurbo/Verilog-Generator-of-Neural-Net-Digit-Detector-for-FPGA/blob/master/images/QV_03.png "Img 3")

* Then go to "Tools" -> "Programmer". Select "output_files/cam_proj.sof" and press "Delete". Then press "Add file..." and
in dialog choose "output_files/output_file.jic". Then press "Start" and wait for "100% Successful" in Progress field.
(see img 4)

![Img 4](https://github.com/ZFTurbo/Verilog-Generator-of-Neural-Net-Digit-Detector-for-FPGA/blob/master/images/QV_04.png "Img 4")

* Now you need to restart device to make it work (for example plug/unplug it from USB).
