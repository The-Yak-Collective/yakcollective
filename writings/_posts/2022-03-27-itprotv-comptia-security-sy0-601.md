---
title: 'ITPro.TV: CompTIA Security+ (SY0-601)'
date: 2022-03-27 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-03-27-itprotv-comptia-security-plus.html
author: 100007
---

# ITPro.TV: CompTIA Security+ (SY0-601)

**author:** Nathan Acks  
**date:** 2022-03-27

# CompTIA Security+ Exam Cram

Today I’ll be reading chapters 21 and 26 of the Security+ Exam Cram, “Secure Mobile Solutions” and “Organizational Security”.

# Communication Methods

CDMA = Code-Division Multiple Access

GSM = Global System for Mobile Communications

GSM is the dominant standard, and is the one that uses SIM (“Subscriber Identity Module”) cards. Exam Cram indicates that CDMA is the more secure cellular standard.

GSM/CDMA describe the voice component of the cellular network. 2G, 3G, and 4G/LTE describe the data standard.

GPRS = General Packet Radio Service

GPRS is the GSM data layer for 2G and 3G networks.

Some satellite phone systems (Inmarsat and Iridium) also use SIM cards.

Bluetooth communication actually involves the creation of a very small (two device) network, terms a PAN (“Personal Area Network”) or “piconet”. ANT+ is a similar, but even lower-powered, standard that is designed to talk to sensors and is currently only used by Android.

There are three NFC modes:

(1) Read/Write (only in one direction, with the “active” device initiating the read/write)

(2) Peer-to-Peer (read/write in _both_ directions)

(3) Card Emulation (for credit card payments)

- [General Packet Radio Service (Wikipedia)](https://en.wikipedia.org/wiki/General_Packet_Radio_Service)

# Device, Application, and Content Management

Android’s implementation of SELinux is called SEAndroid.

# Mobile Device Management

Three levels:

- Mobile Application Management (MAM) is only concerned with application-level controls.
- Mobile Device Management (MDM) extends MAM to include device configuration, provisioning, and inventory management.
- Unified Endpoint Management (UEM) extends MDM with DLP, IAM, and threat management. It generally also includes the management of laptops and desktops in addition to mobile devices.

I guess that Google’s MDM solution is somewhere north of an MDM but far short of a UEM then.

# Mobile Content Management

MCM = Mobile Content Management

This seems to be just the (controlled!) method/application through which the mobile device accesses corporate data. The key point is that this is a step up from just viewing content via a browser, and thus requires leveraging some level of on-device security.

# Mobile Application Management

Some MDM solutions use their own encrypted document store and wrap application system calls for accessing this data.

Exam Cram recommends deriving encryption keys from a user password rather than storing them on device in order to guard against device rooting.

# Biometrics and Context-Aware Authentication

Exam Cram recommends combining biometrics with a device PIN. But I’ve never seen an iOS or Android device offer this option.

“Context-aware authentication” in this case is just referring to using additional metadata about a user’s login to decide whether to allow or deny the action, or perhaps to request an additional form of authentication. Exam Cram seems to explicitly link this with machine learning. So, perhaps a bit more powerful than Google’s “Context-Aware Access”.

- [Context-Aware Access overview](https://support.google.com/a/answer/9275380)

# Remote Wiping

Interesting… There are local device wiping tools that can be triggered when a SIM card change is detected.

# Geolocation, Geofencing, and Push Notifications

Exam Cram notes that geofencing is a tactic that can be used to prevent time theft. Sufficiently fine-grained geofencing can actually be used to clock people in and out.

# Storage Segmentation and Containerization

Android’s “work environment”, etc. Typically device containers are encrypted using AES, and generally contain work _applications_ as well as data. Some solutions wrap system calls to ensure that data is encrypted in transit to/from the device as well.

Device containerization is limited by application compatability.

# Full Device Encryption (FDE)

MicroSD HSMs exist. Typically used for key management.

# Enforcement and Monitoring

EMM = Enterprise Mobility Management

Typically this is a combination of MDM, MAM, and IAM.

# Custom Firmware, Carrier Unlocking, and OTA Updates

Android supports the deployment of “Device Policy Controller” (DPC) applications that can control the OTA update process. (It sounds like this is similar to the control available on Chrome OS devices.)

# Storage and USB OTG

USB OTG = USB On-the-Go = USB Host Mode

Exam Cram emphasizes the importance of encrypting micoSD cards.

# Enforcement for Normal Device Functions

Exam Cram emphasizes the importance of including policy guidance w.r.t. camera and microphone usage.

# Wi-Fi Methods, Tethering, and Payments

Wi-Fi Direct is a combination of setting up a mobile device as a hotspot with the use of Wi-Fi Protected Setup (WPS) to exchange password information. Given that WPS is a known broken standard, this is problematic. Wi-Fi Direct using WPA3 does _not_ use WPS, however.

Wi-Fi Direct is typically used for short-term device-to-device communications, in contrast to tethering (which is about using the mobile device as a gateway to the broader internet).

Ad hoc networking is formally the creation of a “Mobile Ad hoc Network” “(MANET), and is part of the 802.11 standard (as the “Independent Basic Service Set”, or IBSS). IBSS nodes can use _any_ available form of Wi-Fi encryption, including _none_.

Exam Cram defines “tethering” broadly to include _any_ use of a mobile device by another system to reach the internet. So this includes both physical tethering and the use of a mobile phone as a hotspot.

# BYOD, CYOD, COPE, and Corporate-Owned Devices

BYOD = Bring Your Own Device

CYOD = Choose Your Own Device. Basically, a menu of corporate-owned devices.

COBO = Corporate-Owned, Business Only. Corporate-owned devices, generally pre-determined based on role. Also called UWYT (“Use What You are Told”).

COPE = Corporate-Owned, Personally Enabled. Like COBO but allows for personal use.

# Virtual Desktop Infrastructure

VDI = Virtual Desktop Infrastructure

A variant called VMI (“Virtual Mobile Infrastructure”) actually hosts a copy of a mobile OS. Weird. I can’t imagine that this works very well, but Exam Cram speaks of it quite highly.

VDI access is either client-based (specialized application) or browser-based.

# Forensics

Make sure that corporate policy includes the understanding that devices - including personal data! - may be imaged as part of an investigation.

# Shell and Script Environments

I just realized this, but \*NIX numeric permissions are listed in “descending” order of their significance - execution (1, arguably the most powerful since you may be able to make changes to the system with it), write (2, lets you make changes to the file/directory), and read (4, only allows reading the contents of the file/directory).

Some \*NIX commands that I’m less familiar with:

- logger - Send messages to syslog
- arp - Display the system ARP table
- tracert - Windows ‘traceroute’ equivalent
- nbtstat - NetBIOS troubleshooting tool, similar to netstat
- hping - General packet creation/manipulation/disassembly tool
- dnsenum - General DNS enumeration/reconnaissance tool
- theharvester - OSINT reconnaissance tool
- scanless - Simple port scanner that uses third-party webservices to mask your IP
- cuckoo - Malware analysis sandbox
- tcpdump - TCP/IP packet capture tool
- windump - Windows equivalent of tcpdump
- tcpreplay - Replay previously captured TCP/IP traffic
- memdump - Dumps the contents of system memory

# Network Reconnaissance and Discovery

A “port sweep” is a port scan across multiple hosts.

WINS = Windows Internet Naming Service

It turns out that “ping” stands for “Packet Internet Groper”.

Sn1per is a generalized scanning tool, similar to Nessus.

Remember that TTL is actually the hop count in ICMP, not an actual (human) time!

- [hping](http://www.hping.org/)
- [dnsenum (Kali Linux Tools)](https://www.kali.org/tools/dnsenum/)
- [theHarvester](https://github.com/laramies/theHarvester)
- [Sn1per](https://github.com/1N3/Sn1per)
- [scanless](https://github.com/vesche/scanless)
- [Cuckoo](https://cuckoosandbox.org/)

# Exploitation Frameworks

- Metasploit (the one everyone talks about)
- Canvass
- Core Impact
- BeEF (“Browser Exploitation Framework”, used to attack browsers using client-side scripts)

# Packet Capture and Replay

The “Microsoft Message Analyzer” is a protocol analyzer built into Windows Server.

Technically a protocol sniffer just gathers packets while a protocol analyzer actually helps you break them down and, well, analyze them. But in reality most tools in one category provide at least some functionality in the other.

- [WinDump](https://www.winpcap.org/windump/)

# Password Crackers

Interesting legal complication (though it makes sense): In a corporate environment, it’s important to only provide/view password strength information when cracking user passwords, as displaying the full password can make it unclear who is actually using a particular account in the logs.

# Forensics and Data Sanitization

Data Sanitization: The removal of data from a device in a fashion designed to make recovery as difficult as possible.

Types of data sanitization:

- Clear - Normal read/write commands.
- Purge - The use of techniques designed to make data recovery difficult/impossible. Normally what we mean when we talk about “data sanitization”.
- Destroy - Render the device inoperative and the data inaccessible/unrecoverable.

Some other tools that Exam Cram mentions explicitly:

- WinHex (Windows hex editor)
- FTK Imager (disk imaging tool)
- Autopsy (storage media forensics tool)

# ITPro.TV: CompTIA Security+ (SY0-601)

# Mobile Device Deployment

“Unified Endpoint Management” (UEM) is a single “pane of glass” that combines MDM, EMM, and MAM that covers all sorts of devices - everything from laptops to smartphones (and often desktops too, despite them not actually being mobile).

The Microsoft Endpoint Security Manager provides UEM for Windows. Intune is the MDM component of this.

Despite iOS’s popularity among the upper classes, world wide there are roughly 4 Android device for every iOS device.

SELinux/SEAndroid operate under an implicit deny model.

Things a microSD HSM can do:

- Network authentication
- Storage encryption
- Key generation/rotation
- End-to-end encryption management

ITPro.TV defines COPE (Corporate-Owned, Personally Enabled) broadly as the traditional corporate-owned device model.

# Mobile Device Management And Enforcement

This episode is a walk-through of the Microsoft Endpoint Security Manager.

Heh. Dan Lowrie gives a shout-out to Signal as an example of end-to-end encrypted messaging.

# Mobile Device Connections

IMEI = International Mobile Equipment Identifier. A bit like a MAC address for mobile devices on GSM and UTMS networks.

IMSI = International Mobile Subscriber Identifier. Identifies a particular _user_ (unlike the IMEI, which identifies a _device_). Used on GSM and UTMS networks, stored in SIM cards.

Wi-Fi network standard names:

- 802.11a (Wi-Fi 2) - 54 Mbps, 5 GHz
- 802.11b (Wi-Fi 1) - 11 Mbps, 2.4 GHz
- 802.11g (Wi-Fi 3) - 54 Mbps, 2.4 GHz
- 802.11n (Wi-Fi 4) - 600 Mbps, 2.4 GHz + 5 GHz
- 802.11ac (Wi-Fi 5) - 3.6 Gbps, 5 GHz
- 802.11ax (Wi-Fi 6) - 14 Gbps, 2.4 GHz + 5 GHz + 6 GHz

NFC works over a distance of ~4”. Operates at 13.56 MHz.

Infrared tops out at ~16 Mbps.

Bluetooth standards:

- 1.0 - 732 Kbps
- 1.2 - 732 Kbps
- 2.0 + EDR - 3 Mbps
- 2.1 + EDR - 3 Mbps
- 3.0 + HS - 24 Mbps
- 4.0 + BLE - 3 Mbps
- 4.1 + BLE - 3 Mbps

USB standards:

- 1.0 (Low Speed) - 1.5 Mbps
- 1.1 (Full Speed) - 12 Mbps
- 2.0 (High Speed) - 480 Mbps
- 3.2 Gen1x1 (SuperSpeed) - 5 Gbps
- 3.2 Gen2x1 (SuperSpeed+) - 10 Gbps
- 3.2 Gen2x2 (SuperSpeed 20 Gbps) - 20 Gbps
- 4 (USB4 Gen 3x2 40 Gbps) - 40 Gbps

This table isn’t really 100% accurate (though it’s better than the one that ITPro.TV displayed). Actual USB standards are a freakin’ mess.

There are 24 active GPS satellites + 3 standbys. GPS is a US system; alternatives are GLONASS (Russia), Galileo (European Union), and BeiDou (China).

RFID tags come in two varieties: Passive (powered by the reader) and active (self-powered).

- [Bluetooth (Wikipedia)](https://en.wikipedia.org/wiki/Bluetooth)
- [USB (Wikipedia)](https://en.wikipedia.org/wiki/USB)

# Specialized Systems

SCADA = Supervisory Control and Data Acquisition

ICS = Industrial Control Systems

General control mechanical and electrical automation in heavy industry and critical infrastructure. Increasingly called “operational technology” (OT).

IoT = Internet of Things

Put computers in all the things, because what could possibly go wrong? Mostly distinguished from OT by being more robust in a network environment and generally being built using a Linux or Windows base.

Embedded systems are just embedded micro-computers. More often found in IoT than OT.

- Raspberry Pi
- Field Programmable Gate Array (FPGA)
- Arduino

There’s also a variety of specialized, proprietary systems for which minimal documentation exists online:

- Medical systems
- HVACs
- Drones
- Self-driving cars & airplane autopilots
- Surveillance systems
- VoIP desk phones
- Multi-function (MFD) printers

Many of these are controlled using “real-time operating systems” (RTOS) that are designed with low latency in mind.

Communication standards commonly used in specialized devices:

- 5G
- Narrow-band (NB-IoT, LPWAN)
- Baseband radio
- Zigbee (IEEE 802.15.4 LR-PWAN)

With the exception of 5G, these are all distinguished by being very low power and very low bandwidth.

Security concerns? It’s basically a universe of crap. Have fun!

