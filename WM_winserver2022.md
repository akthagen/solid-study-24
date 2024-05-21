### Installation Steps:

1. **Installing the ISO**
    - [Download Windows Server 2022 ISO](https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2022)
    - Fill in the required information to download:
        - Language: English (United States)
        - Edition: 64-bit
    - Proceed with the download.

2. **Download and Install VM**
    - [Download VirtualBox](https://www.virtualbox.org/wiki/Downloads)
    - Install VirtualBox.
    - Start VirtualBox.
    - Create a new virtual machine:
        - Name: Winserver2022
        - Base memory: 4096 MB
        - Processors: 2 or more
        - Disk: 50GB or as needed
    - Configure settings: 
        - Storage --> Disk file --> Select the Windows Server 2022 ISO.

3. **Run**
    - Use the desktop experience version.
    - Custom install --> Select the 50GB drive created earlier.
    - Complete the installation.
    - Login to Windows Server.
    - Yes to network settings.
    - Go to: `Server Manager` --> `Manage` --> `Add Roles and Features`.
    - Role-based or feature-based installation.
    - Roles: Active Directory Domain Services.
    - Default settings for .NET.
    - Press Install.
    - After installation, click on `Promote this server to a domain controller`.
    - Add a new forest (e.g., "Winserver2022").
    - NetBIOS name should auto-populate.
    - Install and reboot.

4. **Post-Installation**
    - Login to the domain controller.
    - Pin `Active Directory Users and Computers` to the taskbar.
    - Pin `Open PowerShell (x86)` to the taskbar.